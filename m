From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: No need to wait for data page
 writeback by force
Date: Thu, 22 Sep 2016 18:50:36 +0800
Message-ID: <4a65970f-4afd-8fb1-5dcf-f6e5391c2b87@huawei.com>
References: <1474454462-30527-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bn1al-0000ln-7Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Sep 2016 10:50:59 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bn1aj-000560-7V
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Sep 2016 10:50:59 +0000
In-Reply-To: <1474454462-30527-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: heyunlei@huwei.com

Hi Yunlei,

On 2016/9/21 18:41, Yunlei He wrote:
> No need to wait for data page writeback, wait or not
> can be decided by device.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index e78501c..71e4a0f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1658,7 +1658,7 @@ void f2fs_wait_on_encrypted_page_writeback(struct f2fs_sb_info *sbi,
>  
>  	cpage = find_lock_page(META_MAPPING(sbi), blkaddr);
>  	if (cpage) {
> -		f2fs_wait_on_page_writeback(cpage, DATA, true);
> +		f2fs_wait_on_page_writeback(cpage, DATA, false);

You can see why we need to wait page writebacked in this commit 08b39fbd5978
("f2fs crypto: fix racing of accessing encrypted page among"), here, I think we
should not let that page slip during writebacking even driver supports accessing
writebacking page.

Thanks,

>  		f2fs_put_page(cpage, 1);
>  	}
>  }
> 


------------------------------------------------------------------------------
