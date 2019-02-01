From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 3/7] f2fs: try to keep CP_TRIMMED_FLAG after
 successful umount
Date: Fri, 1 Feb 2019 23:58:18 +0800
Message-ID: <fe630d9c-0e5a-3e44-c8d4-5eddb1c729d7@kernel.org>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
 <20190128234717.77225-3-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128234717.77225-3-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019-1-29 7:47, Jaegeuk Kim wrote:
> If every discard were issued successfully, we can avoid further discard.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
