From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/5] f2fs: add auto tuning for small devices
Date: Tue, 27 Feb 2018 18:35:20 +0800
Message-ID: <38b99899-2e29-4f80-9552-8506900ebc96@huawei.com>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
 <20180226174731.26679-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226174731.26679-2-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/2/27 1:47, Jaegeuk Kim wrote:
> If f2fs is running on top of very small devices, it's worth to avoid abusing
> free LBAs. In order to achieve that, this patch introduces some parameter
> tuning.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
