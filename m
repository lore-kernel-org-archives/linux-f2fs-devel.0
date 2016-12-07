From: Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 1/2] f2fs: detect wrong layout
Date: Wed, 7 Dec 2016 12:16:50 -0800
Message-ID: <20161207201650.GA125037@google.com>
References: <20161207011625.15591-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ebiggers@google.com>) id 1cEieC-0001M0-EV
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Dec 2016 20:17:00 +0000
Received: from mail-pg0-f53.google.com ([74.125.83.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cEieB-0003sr-MN
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Dec 2016 20:17:00 +0000
Received: by mail-pg0-f53.google.com with SMTP id 3so165461128pgd.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 07 Dec 2016 12:16:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161207011625.15591-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Tue, Dec 06, 2016 at 05:16:24PM -0800, Jaegeuk Kim wrote:
> Previous mkfs.f2fs allows small partition inappropriately, so f2fs should detect
> that as well.
> 
> Refer this in f2fs-tools.
> 
> mkfs.f2fs: detect small partition by overprovision ratio and # of segments
> 
> Reported-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---

Hi Jaegeuk, I tested these two patches and they seem to work correctly --- the
kernel now doesn't allow mounting a 32 MB f2fs filesystem.

Thanks!

Eric

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today.http://sdm.link/xeonphi
