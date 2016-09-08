From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: check free_sections for defragmentation
Date: Fri, 9 Sep 2016 00:07:20 +0800
Message-ID: <9b5dcb11-9629-feb5-a7b2-ffcaf006a08b@kernel.org>
References: <20160901204605.21448-1-jaegeuk@kernel.org>
 <33559c8d-fa39-219c-fff5-18e5586957e7@kernel.org>
 <20160908001855.GB14665@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160908001855.GB14665@jaegeuk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/9/8 8:18, Jaegeuk Kim wrote:
> I just wanted to fix this without any multiple changes.
> We can do like this as well. :)
> 
> From 6526f0377fd6616ae65b854fbd614e8ed9598fdd Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Thu, 1 Sep 2016 12:02:51 -0700
> Subject: [PATCH] f2fs: check free_sections for defragmentation
> 
> Fix wrong condition check for defragmentation of a file.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>
