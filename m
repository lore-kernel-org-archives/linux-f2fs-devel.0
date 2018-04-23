From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] Revert "f2fs: introduce f2fs_set_page_dirty_nobuffer"
Date: Mon, 23 Apr 2018 16:22:08 +0800
Message-ID: <7529231e-e567-34dc-e649-41b0ce284d9c@huawei.com>
References: <20180421040825.77660-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180421040825.77660-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/4/21 12:08, Jaegeuk Kim wrote:
> This patch reverts copied f2fs_set_page_dirty_nobuffer to use generic function
> for stability.
> 
> This reverts commit fe76b796fc5194cc3d57265002e3a748566d073f.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
