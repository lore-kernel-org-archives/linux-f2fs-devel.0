From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: use crc and cp version to
 determine roll-forward recovery
Date: Thu, 29 Sep 2016 17:53:00 -0700
Message-ID: <20160930005300.GC44999@jaegeuk>
References: <20160920025504.72524-1-jaegeuk@kernel.org>
	<5b3d81fe-902e-5512-4766-30ad62390373@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bpm4d-0007fL-Nf
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Sep 2016 00:53:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bpm4b-0001ph-QW
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Sep 2016 00:53:11 +0000
Content-Disposition: inline
In-Reply-To: <5b3d81fe-902e-5512-4766-30ad62390373@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, Sep 29, 2016 at 08:01:32PM +0800, Chao Yu wrote:
> On 2016/9/20 10:55, Jaegeuk Kim wrote:
> > Previously, we used cp_version only to detect recoverable dnodes.
> > In order to avoid same garbage cp_version, we needed to truncate the next
> > dnode during checkpoint, resulting in additional discard or data write.
> > If we can distinguish this by using crc in addition to cp_version, we can
> > remove this overhead.
> > 
> > There is backward compatibility concern where it changes node_footer layout.
> > But, it only affects the direct nodes written after the last checkpoint.
> > We simply expect that user would change kernel versions back and forth after
> > stable checkpoint.
> 
> Seems with new released v4.8 f2fs, old image with recoverable data could be
> mounted successfully, but meanwhile all fsynced data which needs to be recovered
> will be lost w/o any hints?
> 
> Could we release a new version mkfs paired with new kernel module, so we can tag
> image as a new layout one, then new kernel module can recognize the image layout
> and adjust version suited comparing method with old or new image?

Hmm, how about adding a checkpoint flag like CP_CRC_RECOVERY_FLAG?
Then, we can proceed crc|cp_ver, if the last checkpoint has this flag.

Any thought?

> 
> Thanks,
> 
> 

------------------------------------------------------------------------------
