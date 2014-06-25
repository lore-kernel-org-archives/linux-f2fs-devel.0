From: Brian Chadwick <brianchad@westnet.com.au>
Subject: cp hangs with large source tree
Date: Wed, 25 Jun 2014 15:37:09 +1000
Message-ID: <53AA6005.2030405@westnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <brianchad@westnet.com.au>) id 1WzftZ-0001z8-DV
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Jun 2014 05:37:21 +0000
Received: from icp-osb-irony-out2.external.iinet.net.au ([203.59.1.218])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WzftW-00025I-JS for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Jun 2014 05:37:21 +0000
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

Kernel 3.15.0 ... I tried copying a large tree full of many small files 
(kernel source) onto a drive formatted with F2FS. The copy seems to 
proceed normally, but when all files appear to be copied, cp seems to 
hang and does not seem to terminate properly. Its waiting for something 
I assume. This also happens with 3.16.0-rc{1,2}. cp responds to Ctrl-C 
and terminates, and the files appear to be there on the F2FS partition.

It works as expected with Kernel 3.14.8

Any clues?

Brian

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
