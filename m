From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: use crc and cp version to determine
 roll-forward recovery
Date: Thu, 29 Sep 2016 20:01:32 +0800
Message-ID: <5b3d81fe-902e-5512-4766-30ad62390373@huawei.com>
References: <20160920025504.72524-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160920025504.72524-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/9/20 10:55, Jaegeuk Kim wrote:
> Previously, we used cp_version only to detect recoverable dnodes.
> In order to avoid same garbage cp_version, we needed to truncate the next
> dnode during checkpoint, resulting in additional discard or data write.
> If we can distinguish this by using crc in addition to cp_version, we can
> remove this overhead.
> 
> There is backward compatibility concern where it changes node_footer layout.
> But, it only affects the direct nodes written after the last checkpoint.
> We simply expect that user would change kernel versions back and forth after
> stable checkpoint.

Seems with new released v4.8 f2fs, old image with recoverable data could be
mounted successfully, but meanwhile all fsynced data which needs to be recovered
will be lost w/o any hints?

Could we release a new version mkfs paired with new kernel module, so we can tag
image as a new layout one, then new kernel module can recognize the image layout
and adjust version suited comparing method with old or new image?

Thanks,
