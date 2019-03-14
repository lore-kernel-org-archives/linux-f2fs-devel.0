From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: set pin_file under CAP_SYS_ADMIN
Date: Thu, 14 Mar 2019 22:34:11 +0800
Message-ID: <394e84f9-73d6-ae5a-40da-64c864b7c7ee@kernel.org>
References: <20190313231619.31453-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313231619.31453-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019-3-14 7:16, Jaegeuk Kim wrote:
> Android uses pin_file for uncrypt during OTA, and that should be managed by
> CAP_SYS_ADMIN only.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
