From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: rework fault injection handling to avoid a warning
Date: Tue, 14 Aug 2018 14:05:52 +0800
Message-ID: <bee2baa8-1768-4e80-9f63-baf52d6359b9@huawei.com>
References: <20180813213909.3125189-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180813213909.3125189-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Yunlei He <heyunlei@huawei.com>, Sheng Yong <shengyong1@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/8/14 5:38, Arnd Bergmann wrote:
> When CONFIG_F2FS_FAULT_INJECTION is disabled, we get a warning about an
> unused label:
> 
> fs/f2fs/segment.c: In function '__submit_discard_cmd':
> fs/f2fs/segment.c:1059:1: error: label 'submit' defined but not used [-Werror=unused-label]
> 
> This could be fixed by adding another #ifdef around it, but the more
> reliable way of doing this seems to be to remove the other #ifdefs
> where that is easily possible.
> 
> By defining time_to_inject() as a trivial stub, most of the checks for
> CONFIG_F2FS_FAULT_INJECTION can go away. This also leads to nicer
> formatting of the code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
