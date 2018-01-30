From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [f2fs-tools] v1.10.0
Date: Tue, 30 Jan 2018 14:41:25 -0800
Message-ID: <20180130224125.GC65489@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1egeaq-00066a-Ex
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Jan 2018 22:41:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1egeap-0008D5-PJ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Jan 2018 22:41:32 +0000
Received: from localhost (unknown [104.132.0.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1A7CB21780
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 30 Jan 2018 22:41:26 +0000 (UTC)
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
To: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>

Hi all,

Let me release f2fs-tools, v1.10.0.

This release includes:
- build support for Mac/Windows
- sparse support for Android build
- --dry-run for fsck.f2fs
- -q to preserve quota limits

And lots of bug fixes and enhancements were introduced.

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
