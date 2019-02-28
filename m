From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: give random value to i_generation
Date: Thu, 28 Feb 2019 09:09:25 +0800
Message-ID: <2ab4f75b-22ef-c816-1367-e5b74d5247a6@huawei.com>
References: <20190226174507.76205-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226174507.76205-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/2/27 1:45, Jaegeuk Kim wrote:
> This follows to give random number to i_generation along with commit
> 232530680290b ("ext4: improve smp scalability for inode generation")
> 
> This can be used for DUN for UFS HW encryption.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
