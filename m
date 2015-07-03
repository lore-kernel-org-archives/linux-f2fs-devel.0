From: Josh Dener <denerjosh@yahoo.com>
Subject: Design questions (rsv space & nat)
Date: Fri, 3 Jul 2015 17:05:02 +0000 (UTC)
Message-ID: <2062337506.1741901.1435943102912.JavaMail.yahoo@mail.yahoo.com>
Reply-To: Josh Dener <denerjosh@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <denerjosh@yahoo.com>) id 1ZB4RT-0000Q2-BC
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jul 2015 17:07:59 +0000
Received: from nm35-vm3.bullet.mail.ne1.yahoo.com ([98.138.229.99])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZB4RS-0004V8-BG
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jul 2015 17:07:59 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi,

If I got it right, the overprovisioning space gets used to keep writing in LFS mode even when when there are too many dirty segments, until it falls below reserved, when it switches to SSR. The reserved space is needed for "cleaning" - not sure about the details.

But what's interesting is that the reserved space depends only on the overprovisioned percentage at format time. Volume size has no influence. Since all the overpsovisioning can be consumed normally, this doesn't make sense to me - why would you need more reserve in any case?

In fact, this can lead to situations where less overprovisioning reserves more total space, for example with a 13 GB volume (6613 segments, of which 6565 are the main area) if you request 2% OP you get 129 segments of OP and 108 of reserve, but requesting 1% gives you 63 OP and 208 reserve, more in total!

In fact you'd get a 208 reserve even for a tiny volume. So my question is, why does the reserved space depend on overprovisioning percentage, and only that?

Another design question - the NAT's purpose is to cut off tree updates when moving blocks around. But it covers just node blocks. So to move a data block, you update a node block, then update the NAT to point to this new node block. Wouldn't it be better for the NAT to cover data blocks, so when some are moved, only the NAT (and not the node blocks) has to be updated?

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
