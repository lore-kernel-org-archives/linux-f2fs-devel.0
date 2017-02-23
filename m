From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] f2fs: provide more chance for node and data to get
 ssr segment
Date: Wed, 22 Feb 2017 17:17:54 -0800
Message-ID: <20170223011754.GH4003@jaegeuk.local>
References: <1487767851-819-1-git-send-email-yunlong.song@huawei.com>
 <1487767851-819-3-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487767851-819-3-git-send-email-yunlong.song@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yunlong,

I've been testing the similar patches as I attached.

Thanks,

On 02/22, Yunlong Song wrote:
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9d13743..5fe71b9 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1540,12 +1540,17 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
>  {
>  	struct curseg_info *curseg = CURSEG_I(sbi, type);
>  	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
> +	int old_type = type;
>  
>  	if (IS_NODESEG(type)) {
>  		for (; type >= CURSEG_HOT_NODE; type--)
>  			if (v_ops->get_victim(sbi, &(curseg)->next_segno,
>  							BG_GC, type, SSR))
>  				return 1;
> +		for (type = old_type + 1; type <= CURSEG_COLD_NODE; type++)
> +			if (v_ops->get_victim(sbi, &(curseg)->next_segno,
> +							BG_GC, type, SSR))
> +				return 1;
>  		return 0;
>  	}
>  
> @@ -1554,6 +1559,10 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
>  		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
>  						BG_GC, type, SSR))
>  			return 1;
> +	for (type = old_type + 1; type <= CURSEG_COLD_DATA; type++)
> +		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
> +						BG_GC, type, SSR))
> +			return 1;
>  	return 0;
>  }
>  
> -- 
> 1.8.5.2

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-f2fs-find-data-segments-across-all-the-types.patch"

>From 92b42757ca01d6c03c4af7bb6e169855605c59ae Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed, 22 Feb 2017 17:10:18 -0800
Subject: [PATCH 1/2] f2fs: find data segments across all the types

Previously, if type is CURSEG_HOT_DATA, we only check CURSEG_HOT_DATA only.
This patch fixes to search all the different types for SSR.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f3d80ccd556f..605cda3e17e3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1529,16 +1529,23 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
+	int i;
+
+	/* need_SSR() already forces to do this */
+	if (v_ops->get_victim(sbi, &(curseg)->next_segno, BG_GC, type, SSR))
+		return 1;
 
 	if (IS_NODESEG(type))
-		return v_ops->get_victim(sbi,
-				&(curseg)->next_segno, BG_GC, type, SSR);
+		return 0;
 
 	/* For data segments, let's do SSR more intensively */
-	for (; type >= CURSEG_HOT_DATA; type--)
+	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
+		if (i == type)
+			continue;
 		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
-						BG_GC, type, SSR))
+						BG_GC, i, SSR))
 			return 1;
+	}
 	return 0;
 }
 
-- 
2.11.0


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-f2fs-do-SSR-for-node-segments-more-aggresively.patch"

>From cf25da1cb6af3a516f96f6ea3edf98307b089397 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed, 22 Feb 2017 17:02:32 -0800
Subject: [PATCH 2/2] f2fs: do SSR for node segments more aggresively

This patch gives more SSR chances for node blocks.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 605cda3e17e3..9f819eb4749e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1529,17 +1529,22 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
-	int i;
+	int i, n;
 
 	/* need_SSR() already forces to do this */
 	if (v_ops->get_victim(sbi, &(curseg)->next_segno, BG_GC, type, SSR))
 		return 1;
 
-	if (IS_NODESEG(type))
-		return 0;
+	/* For node segments, let's do SSR more intensively */
+	if (IS_NODESEG(type)) {
+		i = CURSEG_HOT_NODE;
+		n = CURSEG_COLD_NODE;
+	} else {
+		i = CURSEG_HOT_DATA;
+		n = CURSEG_COLD_DATA;
+	}
 
-	/* For data segments, let's do SSR more intensively */
-	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
+	for (; i <= n; i++) {
 		if (i == type)
 			continue;
 		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
-- 
2.11.0


--SUOF0GtieIMvvwua--
