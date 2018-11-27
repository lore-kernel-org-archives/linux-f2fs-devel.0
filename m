From: PanBian <bianpan2016@163.com>
Subject: Re: [PATCH] f2fs: read page index before freeing
Date: Tue, 27 Nov 2018 11:22:58 +0800
Message-ID: <20181127032258.GA127317@bp>
References: <1542884326-74903-1-git-send-email-bianpan2016@163.com>
 <3ebe6814-586e-77e8-52fa-47fb61d760f5@huawei.com>
 <20181126102841.GA94853@bp>
 <f8957864-fd65-6c45-de07-9e94459bed52@huawei.com>
 <20181127002247.GA109273@bp>
 <28fc6dc0-6f91-1551-57bb-769dc18b9f7b@huawei.com>
Reply-To: PanBian <bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bianpan2016@163.com>) id 1gRTyR-0001a3-Nw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 03:23:43 +0000
Received: from m12-15.163.com ([220.181.12.15])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1gRTyP-00Gj87-9y
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 03:23:43 +0000
Content-Disposition: inline
In-Reply-To: <28fc6dc0-6f91-1551-57bb-769dc18b9f7b@huawei.com>
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

On Tue, Nov 27, 2018 at 11:12:40AM +0800, Chao Yu wrote:
> On 2018/11/27 8:22, PanBian wrote:
> > On Mon, Nov 26, 2018 at 07:07:08PM +0800, Chao Yu wrote:
> >> On 2018/11/26 18:28, PanBian wrote:
> >>> On Mon, Nov 26, 2018 at 05:13:53PM +0800, Chao Yu wrote:
> >>>> Hi Pan,
> >>>>
> >>>> On 2018/11/22 18:58, Pan Bian wrote:
> >>>>> The function truncate_node frees the page with f2fs_put_page. However,
> >>>>> the page index is read after that. So, the patch reads the index before
> >>>>> freeing the page.
> >>>>
> >>>> I notice that you found another use-after-free bug in ext4, out of
> >>>> curiosity, I'd like to ask how do you find those bugs? by tool or code review?
> >>>
> >>> I found such bugs by the aid of a tool I wrote recently. I designed a method 
> >>> to automatically find paired alloc/free functions. With such functions, I
> >>> wrote two checkers, one to check mismatched alloc/free bugs, the other to
> >>> check use-after-free and double-free bugs.
> >>
> >> Excellent! Do you have any plan to open its source or announce it w/ binary
> >> to linux kernel developers, I think w/ it we can help to improve kernel's
> >> code quality efficiently.
> > 
> > Yes. I am now writing a paper about the method. I will open the source code
> > as soon as I complete the paper and some optimizations.
> 
> Cool, if there is any progress, please let f2fs guys know, thank you in
> advance. :)

No problem. It's my honor to apply my tool to the Linux kernel.

> 
> Thanks,
> 
