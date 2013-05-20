import sys, requests, unidecode, re
from selenium import webdriver
from argparse import ArgumentParser
from bs4 import BeautifulSoup
from urlparse import urlparse

def get_pages(url):
    out = []
    resp = requests.get(url)

    if 200 != resp.status_code:
        print "Bad sitemap url"
        return False

    soup = BeautifulSoup(resp.content)

    urls = soup.findAll('url')

    if not urls:
        print "Empty sitemap"
        return False

    for u in urls:
        loc = u.find('loc').string
        slug = u.find('loc').string
        out.append([loc,slug])
    return out

def slugify(str):
    str = unidecode.unidecode(str).lower()
    return re.sub(r'\W+','-',str)

if __name__ == '__main__':
    options = ArgumentParser()
    options.add_argument('-u', '--url', action='store', dest='url', help='URL of the site\'s sitemap')
    options.add_argument('-o', '--output', action='store', dest='out', default='out.txt', help='Full path to where you want the images')
    args = options.parse_args()
    pages = get_pages(args.url)

    driver = webdriver.Remote("http://127.0.0.1:4444/wd/hub", webdriver.DesiredCapabilities.FIREFOX)
    driver.set_window_size(1680,1050)

    for page in pages:
        driver.get(page[0])
        image_name = str(page[1]).replace("http://","")

        if not image_name:
            # assuming root
            image_name = 'home'

        print 'Saving: '+image_name+'.jpg'
        driver.get_screenshot_as_file(args.out+'/'+image_name+'.jpg')

    driver.close()