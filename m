From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2 v3] f2fs: expose /sys/fs/f2fs/features
Date: Sat, 29 Jul 2017 08:23:14 +0800
Message-ID: <8d080265-4ec5-3a4e-408d-9dae57984d62@huawei.com>
References: <20170726012921.53002-1-jaegeuk@kernel.org>
 <20170726214426.GD66153@jaegeuk-macbookpro.roam.corp.google.com>
 <20170728194134.GC27548@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728194134.GC27548@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/7/29 3:41, Jaegeuk Kim wrote:
>  Change log from v2:
>   - add missing new features
>   - fix print out features
> 
>  Change log from v1:
>   - add /sys/fs/f2fs/dev/features
> 
>>From cf512bfeed89d760138ade12014f17fc5779ca04 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Fri, 21 Jul 2017 17:14:09 -0700
> Subject: [PATCH] f2fs: expose features to sysfs entry
> 
> This patch exposes what features are supported by current f2fs build to sysfs
> entry via:
> 
> /sys/fs/f2fs/features/
> /sys/fs/f2fs/dev/features
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
