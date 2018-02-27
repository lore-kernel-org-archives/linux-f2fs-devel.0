From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 5/5] f2fs: don't stop GC if GC is contended
Date: Tue, 27 Feb 2018 18:36:42 +0800
Message-ID: <8d055f09-07f7-fe6a-52e0-5610b36ffcc1@huawei.com>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
 <20180226174731.26679-5-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226174731.26679-5-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/2/27 1:47, Jaegeuk Kim wrote:
> Let's do GC as much as possible, while gc_urgent is set.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
