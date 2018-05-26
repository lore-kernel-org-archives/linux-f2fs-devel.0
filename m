From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH] f2fs: add fsync_mode=nobarrier for non-atomic files
Date: Sat, 26 May 2018 09:16:40 +0800
Message-ID: <6bc5d3c2-811e-eb52-9148-abf79b61256a@huawei.com>
References: <20180526010414.66014-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180526010414.66014-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/5/26 9:04, Jaegeuk Kim wrote:
> For non-atomic files, this patch adds an option to give nobarrier which
> doesn't issue flush commands to the device.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
