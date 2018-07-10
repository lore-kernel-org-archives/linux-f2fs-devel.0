From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: f2fs-tools: release 1.11.0
Date: Tue, 10 Jul 2018 13:01:09 -0700
Message-ID: <20180710200109.GA77535@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fcyp4-00076w-LU
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 20:01:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fcyp3-005R8u-6x
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 20:01:18 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: tytso@mit.edu

Hi all,

Let me release f2fs-tools-v1.11.0.
Please let me know, if you have any issue on this version.

 https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/log/

This release includes:
 - add sg_write_buffer for UFS firmware update in Android
 - wanted_sector_size to specify sector size explicity
 - support fsverity feature bit
 - support lost+found feature

And, it includes some critical bug fixes.

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
