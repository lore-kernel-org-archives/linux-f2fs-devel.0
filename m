From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: don't overwrite node block by SSR
Date: Wed, 8 Mar 2017 20:30:46 +0800
Message-ID: <2be8ba18-21ed-a990-70d1-12be80ed13d2@huawei.com>
References: <20170306215102.3807-1-jaegeuk@kernel.org>
	<20170306215102.3807-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1clakJ-0004bG-5T
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 12:31:11 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1clakH-0001YA-Dd
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 12:31:11 +0000
In-Reply-To: <20170306215102.3807-2-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/3/7 5:51, Jaegeuk Kim wrote:
> This patch fixes that SSR can overwrite previous warm node block consisting of
> a node chain since the last checkpoint.

Good catch!

Need to consider the impact to other accesser, e.g. is_checkpointed_data,
add_discard_addrs?

Thanks,

> 
> Fixes: 5b6c6be2d878 ("f2fs: use SSR for warm node as well")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 2ae36d04d03e..684b869e1861 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1177,6 +1177,12 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>  		if (f2fs_discard_en(sbi) &&
>  			!f2fs_test_and_set_bit(offset, se->discard_map))
>  			sbi->discard_blks--;
> +
> +		/* don't overwrite by SSR to keep node chain */
> +		if (se->type == CURSEG_WARM_NODE) {
> +			if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map))
> +				se->ckpt_valid_blocks++;
> +		}
>  	} else {
>  		if (!f2fs_test_and_clear_bit(offset, se->cur_valid_map)) {
>  #ifdef CONFIG_F2FS_CHECK_FS
> 


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
