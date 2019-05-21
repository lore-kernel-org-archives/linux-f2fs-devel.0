From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] f2fs: always assume that the device is
 idle under gc_urgent
Date: Mon, 20 May 2019 17:11:37 -0700
Message-ID: <20190521001137.GE61195@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190514063623.57162-1-qkrwngud825@gmail.com>
 <20190514063623.57162-3-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hSsNd-0002LM-0g
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 May 2019 00:11:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hSsNb-00CRuL-Qg
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 May 2019 00:11:44 +0000
Content-Disposition: inline
In-Reply-To: <20190514063623.57162-3-qkrwngud825@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Park Ju Hyung <qkrwngud825@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 05/14, Park Ju Hyung wrote:
> This allows more aggressive discards and balancing job to be done
> under gc_urgent.

Let me merge this first. :)

> 
> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
> ---
>  fs/f2fs/f2fs.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 533fafca68f4..14c95116cd3d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2192,6 +2192,9 @@ static inline struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi,
>  
>  static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
>  {
> +	if (sbi->gc_mode == GC_URGENT)
> +		return true;
> +
>  	if (get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_RD_NODE) ||
>  		get_pages(sbi, F2FS_RD_META) || get_pages(sbi, F2FS_WB_DATA) ||
>  		get_pages(sbi, F2FS_WB_CP_DATA) ||
> -- 
> 2.21.0
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
