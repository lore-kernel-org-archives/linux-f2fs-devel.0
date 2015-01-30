From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 4/5] f2fs: should fail mount when trying to recover data on
 read-only dev
Date: Fri, 30 Jan 2015 13:15:02 +0800
Message-ID: <006801d03c4b$d7761c00$86625400$@samsung.com>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
 <1422401503-4769-4-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1422401503-4769-4-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: linux-fsdevel-owner@vger.kernel.org [mailto:linux-fsdevel-owner@vger.kernel.org] On
> Behalf Of Jaegeuk Kim
> Sent: Wednesday, January 28, 2015 7:32 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [PATCH 4/5] f2fs: should fail mount when trying to recover data on read-only dev
> 
> If device is read-only, we should not proceed data recovery.
> But, if the previous checkpoint was done by normal clean shutdown, it's safe to
> proceed the recovery, since there will be no data to be recovered.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

