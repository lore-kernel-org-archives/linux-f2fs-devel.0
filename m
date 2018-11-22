From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: read page index before freeing
Date: Thu, 22 Nov 2018 04:02:22 -0800
Message-ID: <20181122120222.GA52295@jaegeuk-macbookpro.roam.corp.google.com>
References: <1542884326-74903-1-git-send-email-bianpan2016@163.com>
 <2cd91c95-598d-fcc1-b1d6-6fddb224efcf@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2cd91c95-598d-fcc1-b1d6-6fddb224efcf@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Pan Bian <bianpan2016@163.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 11/22, Chao Yu wrote:
> Hi Pan,
> 
> On 2018/11/22 18:58, Pan Bian wrote:
> > The function truncate_node frees the page with f2fs_put_page. However,
> > the page index is read after that. So, the patch reads the index before
> > freeing the page.
> 
> Good catch!

+1

> 
> It will be better to add:
> 
> Fixes: bf39c00a9a7f ("f2fs: drop obsolete node page when it is truncated")
> Cc: <stable@vger.kernel.org>
> 
> > 
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Done.

> 
> Thanks,
