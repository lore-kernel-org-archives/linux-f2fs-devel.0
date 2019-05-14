From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: issue discard commands proactively in
 high fs utilization
Date: Tue, 14 May 2019 14:39:41 +0900
Message-ID: <CAD14+f154_t1-TbbSDb9xV_ikDAWfF+8H7aOSK4VF8UmqWRDAQ@mail.gmail.com>
References: <20180529205048.39694-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529205048.39694-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, May 30, 2018 at 5:51 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> In the high utilization like over 80%, we don't expect huge # of large discard
> commands, but do many small pending discards which affects FTL GCs a lot.
> Let's issue them in that case.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6e40e536dae0..8c1f7a6bf178 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -915,6 +915,38 @@ static void __check_sit_bitmap(struct f2fs_sb_info *sbi,
> +                       dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;

Isn't this way too aggressive?

Discard thread will wake up on 50ms interval just because the user has
used 80% of space.
60,000ms vs 50ms is too much of a stark difference.

I feel something like 10 seconds(10,000ms) could be a much more
reasonable choice than this.

Thanks.
