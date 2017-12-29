From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: fix missing error number for xattr
 operation
Date: Fri, 29 Dec 2017 16:59:50 +0800
Message-ID: <475d4292-bc3e-d781-9673-f9e0da4fe994@huawei.com>
References: <20171229020056.60558-1-jaegeuk@kernel.org>
 <20171229020056.60558-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171229020056.60558-2-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/12/29 10:00, Jaegeuk Kim wrote:
> This fixes generic/449 hang problem caused by no ENOSPC forever which should be
> returned by setxattr under disk full scenario.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
