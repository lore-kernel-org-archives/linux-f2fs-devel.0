From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 3/5] f2fs: avoid write_checkpoint if f2fs is mounted
 readonly
Date: Thu, 29 Jan 2015 19:55:42 +0800
Message-ID: <002c01d03bba$9cf2ad50$d6d807f0$@samsung.com>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
 <1422401503-4769-3-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1422401503-4769-3-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: linux-fsdevel-owner@vger.kernel.org [mailto:linux-fsdevel-owner@vger.kernel.org] On
> Behalf Of Jaegeuk Kim
> Sent: Wednesday, January 28, 2015 7:32 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [PATCH 3/5] f2fs: avoid write_checkpoint if f2fs is mounted readonly
> 
> Do not change any partition when f2fs is changed to readonly mode.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
