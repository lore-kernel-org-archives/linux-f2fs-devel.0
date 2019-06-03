From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v3 4/4] f2fs: Add option to limit required GC
 for checkpoint=disable
Date: Mon, 3 Jun 2019 23:15:37 +0800
Message-ID: <cbd6e561-66c3-da63-d5b4-e81da990bd15@kernel.org>
References: <20190530004906.261170-1-drosen@google.com>
 <20190530004906.261170-5-drosen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530004906.261170-5-drosen@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Rosenberg <drosen@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Jonathan Corbet <corbet@lwn.net>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, kernel-team@android.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019-5-30 8:49, Daniel Rosenberg via Linux-f2fs-devel wrote:
> This extends the checkpoint option to allow checkpoint=disable:%u[%]
> This allows you to specify what how much of the disk you are willing
> to lose access to while mounting with checkpoint=disable. If the amount
> lost would be higher, the mount will return -EAGAIN. This can be given
> as a percent of total space, or in blocks.
> 
> Currently, we need to run garbage collection until the amount of holes
> is smaller than the OVP space. With the new option, f2fs can mark
> space as unusable up front instead of requiring garbage collection until
> the number of holes is small enough.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
