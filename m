From: Daniel Black <daniel.black@au1.ibm.com>
Subject: documentation for atomic writes,
	encryption and other features
Date: Fri, 17 Feb 2017 10:26:53 +1100
Message-ID: <05f5a35f-0176-b9ff-77c9-268466e19750@au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <daniel.black@au1.ibm.com>) id 1ceX30-0001J0-EE
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 01:09:18 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ceX2y-0003Hj-Do
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 01:09:18 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1GNIstt111229 for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 16 Feb 2017 18:27:56 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28n7mgn53n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 16 Feb 2017 18:27:56 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <linux-f2fs-devel@lists.sourceforge.net> from
	<daniel.black@au1.ibm.com>; Fri, 17 Feb 2017 09:27:53 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 01F432CE8046
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 17 Feb 2017 10:27:51 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1GNRgWm7078096 for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 17 Feb 2017 10:27:50 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
	by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1GNRIwX031127 for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 17 Feb 2017 10:27:18 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
	by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	v1GNRIN1030750 for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 17 Feb 2017 10:27:18 +1100
Received: from hopper.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2C93EA01AC
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 17 Feb 2017 10:26:54 +1100 (AEDT)
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

I was looking at Documentation/filesystems/f2fs.txt trying to work out
how to do atomic writes.

I did find https://www.spinics.net/lists/kernel/msg1839691.html which
contains some elements.

It seems F2FS_IOC_DB_OPEN might been replaced by
F2FS_IOC_START_ATOMIC_WRITE looking at fs/f2fs/f2fs.h

I'd really like some documentation to be written in filesystems/f2fs.txt
to aid the use of features that have been so diligently developed. I'd
also like to know what happens when the atomic write size gets too big.

After that perhaps it can be used in application like other storage
systems e.g. https://jira.mariadb.org/browse/MDEV-11417

Keep up the good work.

Cheers,

Daniel Black


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
