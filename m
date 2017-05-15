From: Raouf Rokhjavan <rokhjavan.r@gmail.com>
Subject: f2fs: failed tests in xfstests
Date: Mon, 15 May 2017 12:13:35 +0430
Message-ID: <0083d9ef-9874-50c5-83ea-d69988e48cdd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rokhjavan.r@gmail.com>) id 1dAAfS-0000h7-2z
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 May 2017 07:43:46 +0000
Received: from mail-wm0-f67.google.com ([74.125.82.67])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dAAfR-0002U7-1Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 May 2017 07:43:45 +0000
Received: by mail-wm0-f67.google.com with SMTP id u65so26012052wmu.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 15 May 2017 00:43:44 -0700 (PDT)
Received: from desktopr.example.com ([5.75.200.133])
	by smtp.gmail.com with ESMTPSA id
	b25sm9453459edc.58.2017.05.15.00.43.37
	for <linux-f2fs-devel@lists.sourceforge.net>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 15 May 2017 00:43:38 -0700 (PDT)
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

Hi,

I ran the latest xfstests on f2fs, but some of them failed.

The following list includes the number of failed tests:

generic/026 generic/042 generic/091 generic/102 generic/103 generic/114 
generic/204 generic/240 generic/263 generic/300 generic/389 generic/392

Some of them are related to the ACL, but the most of failures are 
related to ENOSPC. For me, between these tests, the most indispensable 
one is generic/392 which emphasizes  the consistency of data and 
metadata after sync() and datasync().

In order to pass these test, do I have to pass any specific mount option?

Since these tests are generic, does f2fs behave differently from 
expected results?


Regards,

R.R.






------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
