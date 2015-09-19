From: nick <xerofoify@gmail.com>
Subject: Possible Bug in move_encrypted_block
Date: Sat, 19 Sep 2015 13:36:08 -0400
Message-ID: <55FD9D08.5050501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1ZdM3c-0002rs-EG
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 19 Sep 2015 17:36:16 +0000
Received: from mail-io0-f171.google.com ([209.85.223.171])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZdM3b-0003lG-NB
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 19 Sep 2015 17:36:16 +0000
Received: by iofh134 with SMTP id h134so85284738iof.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 19 Sep 2015 10:36:10 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Greetings Jaeguek and others.
Below are the lines fora possible bug in  move_encrypted_block:
err = get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
        if (err)
                goto out;
Also calls of get_dnode_of_data need to hold the semaphone for the superblock
this call is being done on to avoid concurrent access on data being received
here from the superblock and file system on disk. In addition unless I get a
reply to this I will not be sending in a bug fix for this.
Nick

------------------------------------------------------------------------------
