From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix to redirty page if fail to gc data
	page
Date: Sat, 28 May 2016 08:54:22 +0800
Message-ID: <2e7be62f-62b3-bb9a-8831-8208d1d9eeb9@huawei.com>
References: <1463807951-10472-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1b6SWi-0007N3-IA
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 May 2016 00:54:52 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b6SWg-0006uV-0G
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 May 2016 00:54:52 +0000
In-Reply-To: <1463807951-10472-1-git-send-email-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Ping,

On 2016/5/21 13:19, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> If we fail to move data page during foreground GC, we should give another
> chance to writeback that page which was set dirty previously by writer.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/gc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 38d56f6..ee213a8 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -653,12 +653,15 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
>  			.page = page,
>  			.encrypted_page = NULL,
>  		};
> +		bool is_dirty = PageDirty(page);
> +
>  		set_page_dirty(page);
>  		f2fs_wait_on_page_writeback(page, DATA, true);
>  		if (clear_page_dirty_for_io(page))
>  			inode_dec_dirty_pages(inode);
>  		set_cold_data(page);
> -		do_write_data_page(&fio);
> +		if (do_write_data_page(&fio) && is_dirty)
> +			set_page_dirty(page);
>  		clear_cold_data(page);
>  	}
>  out:
> 


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
