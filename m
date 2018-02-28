From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/5 v2] f2fs: add mount option for segment allocation
 policy
Date: Wed, 28 Feb 2018 17:33:35 +0800
Message-ID: <c0e41426-1116-8ded-0399-de9c8201b5a4@huawei.com>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
 <20180228050925.GC81737@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180228050925.GC81737@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/2/28 13:09, Jaegeuk Kim wrote:
> Change log from v1:
>  - add doc :)
> 
> This patch adds an mount option, "alloc_mode=%s" having two options, "default"
> and "reuse".
> 
> In "alloc_mode=reuse" case, f2fs starts to allocate segments from 0'th segment
> all the time to reassign segments. It'd be useful for small-sized eMMC parts.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
