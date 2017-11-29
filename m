From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2 0/5] f2fs: switch to new fscrypt helper
 functions
Date: Wed, 29 Nov 2017 12:35:27 -0800
Message-ID: <20171129203532.87729-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <ebiggers3@gmail.com>) id 1eK96A-0004Ev-Pg
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 29 Nov 2017 20:36:50 +0000
Received: from mail-io0-f195.google.com ([209.85.223.195])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1eK969-00056t-VZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 29 Nov 2017 20:36:50 +0000
Received: by mail-io0-f195.google.com with SMTP id d14so5096941ioc.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 29 Nov 2017 12:36:49 -0800 (PST)
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org, Eric Biggers <ebiggers@google.com>

From: Eric Biggers <ebiggers@google.com>

This series switches f2fs to use the fscrypt helper functions for
open/link/rename/lookup/setattr introduced in v4.15.

These patches were originally sent in "[PATCH 00/25] fscrypt: add some
higher-level helper functions".  I've rebased them onto v4.15-rc1.

Eric Biggers (5):
  f2fs: switch to fscrypt_file_open()
  f2fs: switch to fscrypt_prepare_link()
  f2fs: switch to fscrypt_prepare_rename()
  f2fs: switch to fscrypt_prepare_lookup()
  f2fs: switch to fscrypt_prepare_setattr()

 fs/f2fs/file.c  | 30 +++++++-----------------------
 fs/f2fs/namei.c | 54 +++++++++++++-----------------------------------------
 2 files changed, 20 insertions(+), 64 deletions(-)

-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
