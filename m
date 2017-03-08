From: Philippe De Muyter <phdm@macq.eu>
Subject: f2fs_bug_on in init_dirty_segmap
Date: Wed, 8 Mar 2017 15:24:32 +0100
Message-ID: <20170308142432.GA31333@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <phdm@macqel.be>) id 1clcm6-0006wJ-4J
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 14:41:10 +0000
Received: from smtp2.macqel.be ([109.135.2.61])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1clcm4-0002TB-Cu for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 14:41:10 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp2.macqel.be (Postfix) with ESMTP id 218C8130DDA
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed,  8 Mar 2017 15:24:42 +0100 (CET)
Received: from smtp2.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yNz35DiA96WH
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed,  8 Mar 2017 15:24:33 +0100 (CET)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by smtp2.macqel.be (Postfix) with ESMTP id 25D79130CDB
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed,  8 Mar 2017 15:24:33 +0100 (CET)
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hi f2fs developpers,

Please excuse my maybe dumb question.

I recently encountered a kernel panic at root mount time (thus making my
system unusable, as my root partition is formatted as f2fs) due to the
following segment in fs/f2fs/segment.c:init_dirty_segmap

		if (valid_blocks > sbi->blocks_per_seg) {
                        f2fs_bug_on(sbi, 1); <<<<<<<<<<<<<<<<<<<<
			continue;
		}

Is that really a condition requiring a kernel panic, or could a read-only
mount be allowed ?

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
