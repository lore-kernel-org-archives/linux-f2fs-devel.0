From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: SMR drive test 1; 512GB partition;
 very slow + unfixable corruption
Date: Mon, 21 Sep 2015 10:19:37 +0200
Message-ID: <20150921081937.GA5718@schmorp.de>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZdwK8-0007Ca-QW
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 08:19:44 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZdwK7-0002Od-QL
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 08:19:44 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZdwK1-0000IH-LS
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 08:19:37 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZdwK1-00068i-Gp
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 08:19:37 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1ZdwK1-0001Ul-GL
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 10:19:37 +0200
Content-Disposition: inline
In-Reply-To: <20150921081748.GA5637@schmorp.de>
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

On Mon, Sep 21, 2015 at 10:17:48AM +0200, Marc Lehmann <schmorp@schmorp.de> wrote:
> (-onoatime,inline_xattr,inline_data,flush_merge,extent_cache, note: no

Correction, I copied the wrong line from my log, the mount options were:

   mount -o inline_data,inline_dentry,flush_merge,extent_cache /dev/vg_test/test2 /mnt

So with inline_dentry.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
