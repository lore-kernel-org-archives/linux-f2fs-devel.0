Return-Path: <SRS0=kJcA=GC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC81C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Dec 2020 15:40:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08283221F8;
	Wed, 30 Dec 2020 15:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08283221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kudai-0007TQ-Hd; Wed, 30 Dec 2020 15:40:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <gregkh@linuxfoundation.org>) id 1kudag-0007Sv-NW
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 Dec 2020 15:40:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:In-Reply-To:Date:From:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kldb+huGip3GWWX5MgOCM7ZMA3LkUbT1YU4BMgtG1FY=; b=PHLjCFI0tc2vphNf83umx1mfUB
 V8HGaLZM7ANt/53Vtnv4DUr9TcsVVmC0YV0R38mJzFevP611MkROVHGfc9EsFhYaxvgC2qzsaFvrX
 Y5ypLtT180xBxmeTbQop2C4I+L8KmI7yD0aktxFvZFe6BpC7qYuuJNjtQe7UJDxgz1zg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 In-Reply-To:Date:From:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kldb+huGip3GWWX5MgOCM7ZMA3LkUbT1YU4BMgtG1FY=; b=MnqMJcZVxNBMOxu8vfv0JvInNX
 zx0kppXveHtqxfnk1kgrfZpH+eBXrYPMUpaAb7uDTkJ9c0aSA8HooFiKBQaIo4P0NooFKlnu/IsZb
 TdSJbubH4mDMtEkehGYAscXWcjJO4GbDI4RbA4Hc/RJInOcr5N2KIW+lESorF4QZDmGw=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kudac-00DCN2-Pi
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 Dec 2020 15:40:46 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4996207A6;
 Wed, 30 Dec 2020 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1609342837;
 bh=0ez7jDCrOBi1UyFYmUs5OS4EEwA84jZr/TuB8U9/n+A=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=nrWwFnO3nYYL2DrGFgiD0v4rt/6sKRko4AyAqsJPR18Y/DKRG+4XTcCzuNIa1vlnh
 OSIMGjv8Tei6jLAX0ZJ+aeD19nePbLBhBbF1//VSmkZ4A5UsSqWg5zOzBiZnHDslze
 a+b7lTbp/A51syjtBCb58tR52m05nnH07UTcdwhs=
To: ebiggers@google.com, ebiggers@kernel.org, gregkh@linuxfoundation.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Dec 2020 16:42:03 +0100
In-Reply-To: <20201228191211.138300-3-ebiggers@kernel.org>
Message-ID: <1609342923233253@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-Headers-End: 1kudac-00DCN2-Pi
Subject: [f2fs-dev] Patch "ext4: prevent creating duplicate encrypted
 filenames" has been added to the 4.19-stable tree
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stable-commits@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


This is a note to let you know that I've just added the patch titled

    ext4: prevent creating duplicate encrypted filenames

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     ext4-prevent-creating-duplicate-encrypted-filenames.patch
and it can be found in the queue-4.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Wed Dec 30 04:40:58 PM CET 2020
From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 28 Dec 2020 11:12:09 -0800
Subject: ext4: prevent creating duplicate encrypted filenames
To: stable@vger.kernel.org
Cc: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org
Message-ID: <20201228191211.138300-3-ebiggers@kernel.org>

From: Eric Biggers <ebiggers@google.com>

commit 75d18cd1868c2aee43553723872c35d7908f240f upstream.

As described in "fscrypt: add fscrypt_is_nokey_name()", it's possible to
create a duplicate filename in an encrypted directory by creating a file
concurrently with adding the directory's encryption key.

Fix this bug on ext4 by rejecting no-key dentries in ext4_add_entry().

Note that the duplicate check in ext4_find_dest_de() sometimes prevented
this bug.  However in many cases it didn't, since ext4_find_dest_de()
doesn't examine every dentry.

Fixes: 4461471107b7 ("ext4 crypto: enable filename encryption")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20201118075609.120337-3-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/namei.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2106,6 +2106,9 @@ static int ext4_add_entry(handle_t *hand
 	if (!dentry->d_name.len)
 		return -EINVAL;
 
+	if (fscrypt_is_nokey_name(dentry))
+		return -ENOKEY;
+
 	retval = ext4_fname_setup_filename(dir, &dentry->d_name, 0, &fname);
 	if (retval)
 		return retval;


Patches currently in stable-queue which might be from ebiggers@kernel.org are

queue-4.19/fscrypt-add-fscrypt_is_nokey_name.patch
queue-4.19/ext4-prevent-creating-duplicate-encrypted-filenames.patch
queue-4.19/ubifs-prevent-creating-duplicate-encrypted-filenames.patch
queue-4.19/f2fs-prevent-creating-duplicate-encrypted-filenames.patch


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
