From: Richard Weinberger <richard@nod.at>
Subject: fscrypt: in-place decrypt vs. out-of-place encrypt?
Date: Thu, 22 Sep 2016 10:49:41 +0200
Message-ID: <f3f489f1-3ec0-e8c8-d5ae-ea6b9e5d5571@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1bmziS-00042X-85
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Sep 2016 08:50:48 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bmziQ-0003E6-7j
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Sep 2016 08:50:48 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, David Gstir <david@sigma-star.at>, linux-ext4@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi!

While reading the fscrypt code I noticed that some functions use the bounce pages
and some not.
fscrypt_decrypt_page() and fscrypt_decrypt_bio_pages() work in-place while
fscrypt_encrypt_page() and fscrypt_zeroout_range() use a bounce page.

So, both ext4 and f2fs encrypt data using an extra buffer but decrypt mostly
in-place without the need of an extra buffer.
Why that? I'd assume when decryption can be done in-place also encryption is possible
that way.

I'm working on fscrypt for UBIFS and would like to avoid an extra buffer since memory
is low on embedded systems.

Thanks,
//richard

------------------------------------------------------------------------------
