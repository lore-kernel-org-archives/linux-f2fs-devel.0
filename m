From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix block address for __check_sit_bitmap
Date: Tue, 18 Dec 2018 18:36:15 +0800
Message-ID: <cbfb1b04-34bd-951b-089d-1561e3746d46@huawei.com>
References: <20181218093223.25242-1-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218093223.25242-1-sunqiuyang@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sunqiuyang <sunqiuyang@huawei.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: fangwei1@huawei.com, yuchangchun1@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/12/18 17:32, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> Should use lstart (logical start address) instead of start (in dev) here.
> This fixes a bug in multi-device scenarios.

Good catch!

> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
