From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/5] f2fs: add mount option for segment allocation policy
Date: Tue, 27 Feb 2018 18:33:40 +0800
Message-ID: <3dfa29d2-4a37-f2f2-648d-885dbda1cdf6@huawei.com>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226174731.26679-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2018/2/27 1:47, Jaegeuk Kim wrote:
> This patch adds an mount option, "alloc_mode=%s" having two options, "default"
> and "reuse".
> 
> In "alloc_mode=reuse" case, f2fs starts to allocate segments from 0'th segment
> all the time to reassign segments. It'd be useful for small-sized eMMC parts.

We needs to add Doc for this mount option. ;)

Thanks,
