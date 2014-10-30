From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Subject: f2fs, mount -o sync, sync and cut-off power
Date: Thu, 30 Oct 2014 08:35:40 +0100
Message-ID: <5451EA4C.2040304@mitrol.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Paolo.Minazzi@mitrol.it>) id 1XjkGq-0002SM-JL
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 30 Oct 2014 07:35:48 +0000
Received: from mitrol.it ([82.188.252.170] helo=mail.mitrol.it)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XjkGp-0003pJ-DV for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 30 Oct 2014 07:35:48 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.mitrol.it (Postfix) with ESMTP id 4EBF586C1F
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 30 Oct 2014 08:35:40 +0100 (CET)
Received: from mail.mitrol.it ([127.0.0.1])
	by localhost (mail.mitrol.it [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vycrQgDMxsEj
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 30 Oct 2014 08:35:40 +0100 (CET)
Received: from [127.0.0.1] (mypc193.mitrol2000.it [10.0.0.56])
	by mail.mitrol.it (Postfix) with ESMTPA id F164486B50
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 30 Oct 2014 08:35:39 +0100 (CET)
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

I'm Paolo.
I'm integrating f2fs on an ARM board.
I do not have the power-off button.
The normal way to power-off is to cut-off the power.

I tried to mount in sync mode
     mount -t f2fs -o sync /dev/mmcblk0 /data
     echo Hello > /data/Hello.txt
I realize that if I cut-off the power after "echo" finishes, at the new 
boot I see that f2fs execute the recovery that can be also very long.

If I add the "sync" command
     mount -t f2fs -o sync /dev/mmcblk0 /data
     echo Hello > /data/Hello.txt
     sync
I realize that if I cut-off the power after "sync" finishes, at the new 
boot I do not see the f2fs
recovery and the boot process is very fast.

This means that -o sync is different that execute a sync command after 
each write.
I study deeper the problem reading the source code and I realize that 
"sync" produce a checkpoint.
I tried to add the code to make a checkpoint every n writes. It works 
but is not a clean solution.
I read and tried ipu-policy but I do not think it is realted to my needs.

Is there a solution to force a checkpoint automatically after each write ?
I need
- not lose data on cut-off
- fast boot (I would like to avoid different mount time)
For me the spped of write is not so important.

I would like avoid the following ...
while true
do
     sync
     sleep 1
done

Thanks for your time and for this great project
Paolo Minazzi


------------------------------------------------------------------------------
