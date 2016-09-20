From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: use crc and cp version to determine
 roll-forward recovery
Date: Tue, 20 Sep 2016 23:48:24 +0800
Message-ID: <6d5c6ce9-b9d6-badd-244a-b6126ce14546@kernel.org>
References: <20160920025504.72524-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160920025504.72524-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

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

With it, tests/generic/050 of fstest will fail:

     setting device read-only
     mounting filesystem that needs recovery on a read-only device:
     mount: SCRATCH_DEV is write-protected, mounting read-only
    -mount: cannot mount SCRATCH_DEV read-only
     unmounting read-only filesystem
    -umount: SCRATCH_DEV: not mounted
     mounting filesystem with -o norecovery on a read-only device:

Could you have a look at it?

Thanks,
