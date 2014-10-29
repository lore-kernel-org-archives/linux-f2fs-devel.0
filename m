From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Subject: f2fs, sync, mopunt -o sync, power loss
Date: Wed, 29 Oct 2014 10:37:09 +0100
Message-ID: <5450B545.9030703@mitrol.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Paolo.Minazzi@mitrol.it>) id 1XjPwZ-000057-Up
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 29 Oct 2014 09:53:31 +0000
Received: from mitrol.it ([82.188.252.170] helo=mail.mitrol.it)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XjPwX-000081-23 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 29 Oct 2014 09:53:31 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.mitrol.it (Postfix) with ESMTP id 9766386B94
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 29 Oct 2014 10:37:07 +0100 (CET)
Received: from mail.mitrol.it ([127.0.0.1])
	by localhost (mail.mitrol.it [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1LQbvdmozp5E
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 29 Oct 2014 10:37:07 +0100 (CET)
Received: from [127.0.0.1] (mypc193.mitrol2000.it [10.0.0.56])
	by mail.mitrol.it (Postfix) with ESMTPA id 6BA2B86B50
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 29 Oct 2014 10:37:07 +0100 (CET)
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
boot I see that f2fs execute the recovery.

If I add the "sync" command
     mount -t f2fs -o sync /dev/mmcblk0 /data
     echo Hello > /data/Hello.txt
     sync
I realize that if I cut-off the power after "sync" finishes, at the new 
boot I do not see the f2fs
recovery and the boot process is faster.

This means that -o sync is different that execute a sync command after 
each write.

Is there a solution to force sync automatically after each write ?

I would like avoid the following ...
while true
do
     sync
     sleep 1
done

Thanks for your time and for this great project
Paolo Minazzi


------------------------------------------------------------------------------
