From: Chao Yu <yuchaochina@hotmail.com>
Subject: RE: [f2fs-dev] [PATCH 1/2] f2fs: flush dirty data for bmap
Date: Tue, 20 Oct 2015 23:09:54 +0800
Message-ID: <COL402-EAS1023DF9B41A68EFD8E6FE2EAB390@phx.gbl>
References: <1445280521-25973-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1445280521-25973-1-git-send-email-jaegeuk@kernel.org>
Content-Language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, October 20, 2015 2:49 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org;
> linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim; Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 1/2] f2fs: flush dirty data for bmap
> 
> Users expect bmap will give allocated block addresses.
> Let's play likewise ext4.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
