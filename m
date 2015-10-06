From: Chao Yu <yuchaochina@hotmail.com>
Subject: RE: [f2fs-dev] [PATCH 3/3] f2fs: introduce a periodic checkpoint flow
Date: Tue, 6 Oct 2015 22:54:47 +0800
Message-ID: <COL402-EAS36963917057FDF0512DE24BAB370@phx.gbl>
References: <1444085040-12843-1-git-send-email-jaegeuk@kernel.org> <1444085040-12843-3-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444085040-12843-3-git-send-email-jaegeuk@kernel.org>
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, October 06, 2015 6:44 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 3/3] f2fs: introduce a periodic checkpoint flow
> 
> This patch introduces a periodic checkpoint feature.
> Note that, this is not enforcing to conduct checkpoints very strictly in terms
> of trigger timing, instead just hope to help user experiences.
> The default value is 60 seconds.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Looks good to me except one minor thing that it's better to add a cp_expires
initialization.

Please append all patches of patch set with:
Reviewed-by: Chao Yu <chao2.yu@samsung.com>

Thanks,
