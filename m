From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v5] f2fs: fix to avoid accessing xattr across the boundary
Date: Fri, 10 May 2019 09:14:12 +0800
Message-ID: <57a8cf36-af86-8d4b-856d-e7d70cf2d098@huawei.com>
References: <20190411082646.169977-1-huangrandall@google.com>
 <20190509041535.GA62877@jaegeuk-macbookpro.roam.corp.google.com>
 <bdba5d01-4a31-d8f2-4805-81d167047c84@huawei.com>
 <20190509164814.GA79912@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509164814.GA79912@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Randall Huang <huangrandall@google.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/5/10 0:48, Jaegeuk Kim wrote:
> Okay, how about this?
> 
>>From 2777e654371dd4207a3a7f4fb5fa39550053a080 Mon Sep 17 00:00:00 2001
> From: Randall Huang <huangrandall@google.com>
> Date: Thu, 11 Apr 2019 16:26:46 +0800
> Subject: [PATCH] f2fs: fix to avoid accessing xattr across the boundary

Looks good to me, and more clean. :)

Thanks,
