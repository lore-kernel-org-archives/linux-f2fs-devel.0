From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v7 1/1] f2fs: dax: implement direct access
Date: Tue, 18 Jul 2017 14:47:32 +0800
Message-ID: <124231e8-d3f5-470d-36e4-77e07cf55403@huawei.com>
References: <1500349530-21530-1-git-send-email-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500349530-21530-1-git-send-email-sunqiuyang@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sunqiuyang <sunqiuyang@huawei.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/7/18 11:45, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> This patch implements Direct Access (DAX) in F2FS, including:
> - a mount option to choose whether to enable DAX or not
> - read/write and mmap of regular files in the DAX way
> - zero-out of unaligned partial blocks in the DAX way
> - garbage collection of DAX files, by mapping both old and new physical
>   addresses of a data page into memory and copy data between them directly
> - incompatibility of DAX with inline data, atomic or volatile write, etc.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>
