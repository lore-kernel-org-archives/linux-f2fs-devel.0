From: PanBian <bianpan2016@163.com>
Subject: Re: [PATCH] f2fs: read page index before freeing
Date: Mon, 26 Nov 2018 18:28:41 +0800
Message-ID: <20181126102841.GA94853@bp>
References: <1542884326-74903-1-git-send-email-bianpan2016@163.com>
 <3ebe6814-586e-77e8-52fa-47fb61d760f5@huawei.com>
Reply-To: PanBian <bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bianpan2016@163.com>) id 1gRE8f-0006Wp-QO
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 10:29:13 +0000
Received: from m12-15.163.com ([220.181.12.15])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1gRE8L-0041Xr-Bv
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 10:29:13 +0000
Content-Disposition: inline
In-Reply-To: <3ebe6814-586e-77e8-52fa-47fb61d760f5@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Mon, Nov 26, 2018 at 05:13:53PM +0800, Chao Yu wrote:
> Hi Pan,
> 
> On 2018/11/22 18:58, Pan Bian wrote:
> > The function truncate_node frees the page with f2fs_put_page. However,
> > the page index is read after that. So, the patch reads the index before
> > freeing the page.
> 
> I notice that you found another use-after-free bug in ext4, out of
> curiosity, I'd like to ask how do you find those bugs? by tool or code review?

I found such bugs by the aid of a tool I wrote recently. I designed a method 
to automatically find paired alloc/free functions. With such functions, I
wrote two checkers, one to check mismatched alloc/free bugs, the other to
check use-after-free and double-free bugs.

Best regards,
Pan Bian
