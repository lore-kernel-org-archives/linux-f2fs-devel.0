Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE0D606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Nov 2026 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=K7RiOa94;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cbCuLg8T;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mcypfqgs;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ftuayfA9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=Me4HY6RDfrLVerQRY5371zuyjynQgxvqF5OAQfGji/c=; b=K7RiOa94QH5kjzFpca6KobsNYC
	G36xjUgo8kV6I6GNyz8kovuRiVr7f2Q0CIggjYumAEaXx13L9K1Z1pxY6FAgTd193EGxi2/q7KTcp
	pQw1i3p5SjlfPoRyIbyw+R4/QaYtrqk90wkOngu41TdWvkp/JNmTxDdJOJxr8gOd88hY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWSDi-000000005TY-3SYu;
	Thu, 26 Nov 2026 05:40:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <woni9911@gmail.com>) id 1xWSDh-000000005TK-0twG
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 05:40:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zNemxVisHWzCdnNTLxjDHkkPmfEzkT3CMXkC/wyA6Io=; b=cbCuLg8T6kChT/90F80XtPAkJd
 XpWCxJgE/rRqY2E9hKfeqkJ+sP5IdWjNai6h5eGKyTN/Q0U4Q00L+xjYt0RDQ5qS0o1jS5+BpB71P
 2JwVXVU+MKGx8HjGjPnJ7vYDlyh+Vrn+i3e8YSKjcJjGS9PESa/4DviUOq+elZZOQwP8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zNemxVisHWzCdnNTLxjDHkkPmfEzkT3CMXkC/wyA6Io=; b=mcypfqgsku7T78VV5lN4MCyizH
 nUVd7pCtu4jh9eCAcwXq9vIieSrpRj2fNY2jCEqQkyzm8qZEIykDb8J9vD9S0I/Wmqx489A2F5LB8
 wqhe59txZnwY6X2guFfZFDAOBPW1jsqq/xD8vqosN+1iBa/hdNWpxjovRho3+ALsdgtU=;
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWSDf-000000005tR-3Z48
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 05:40:33 +0000
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3b413997581so5114115a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 21:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795671626; x=1796276426; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zNemxVisHWzCdnNTLxjDHkkPmfEzkT3CMXkC/wyA6Io=;
 b=ftuayfA9EIpc3eRfxhwQPzEM2pPBRMbSeFFBE9wKTZK3Yfa6UWASPCJDO6GjCqmTc2
 Hn303Fc9zgYWiiPB+I55aiIWkkBw4WH269RazVBGT+h/OAOTF8pWpO7TgLTuFHqwZTuq
 NZSSkBNZrRpIzDU3hlqBWyTvYL7fgYnVJbXe8BvwrlV6DrWiaRFWRKNcu5tuSay0bgk6
 A1jmdGUENGETC7cPELdaCmOCY20WNmLK09OawMcmkNMN2pQDJKYF2xNHLue3I/d0HOzj
 4gQxNrn1/VLXhxtfedSZFPhXXuxyX45gnfH2PfdED+JaSn34dbxUwLl/LMzLaJkViZna
 efcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795671626; x=1796276426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zNemxVisHWzCdnNTLxjDHkkPmfEzkT3CMXkC/wyA6Io=;
 b=VegCIoUY8FsXd+p7DDTBd4Bi0rnOcGWLS1ZlPJgJtf5grSlMfTEAi8pt4AemdzyGtx
 Im8raRo8AlqljdZuBivKowLEJt35CzOLiV2yf6wDnxHm8vdZxUxqs7jo29AmemAlccPS
 2guEo6wMMrCYxxlPDzYGGIfkEP/4odmSGHEjHt9PsmkCwu3+maOjXKsuRADu10k7Q7z8
 LoYxGuci/JKeswovtskd7ROkDvodaNzB1noetBV/ZCvAQZTl5Tm057WoiRwYYFjzr2PW
 22c6YCVKcHXV2iaxc8P6ySATiFMNmcv5XFkaMkvyiRmTM7B4mOzR1HlHvJAPWeQXZVGA
 Zu2Q==
X-Gm-Message-State: APuU4Z9BPyudPTtvOp3eOR56+C0+uQxnwkdWT2OU0zvFrW3tWIRAHl8j
 M5C0r9VpPbxY56B2+fMaE8wiaBp1O+xFjcKIyptznu7DDckGkXTf5BH1HQbZMA==
X-Gm-Gg: AZFdTZcNNNySdInx/aMhJtK4Uz56sDcjKMpz/9Ampi+gHQrUA9EJBgtnpE8RH74/fXb
 dXAZJnbCiOwP12yRYAbuCg0lRaICiBrW0pUWIAqzh6KMfK7/Z7idNqmbK5zA8z2NZTVkUp5tyzS
 FEFZ7Tesq99QON2GsfkyremCpcrj+slB+tEaEBKQFSqZRP/aEGv+1izbqm5/dQTqJW0LeLmgMtk
 kyd/tCNNrtNqtTTo9agnFpnXcxNzOLhPKmC4rUyshrWLrmnGKdTHXNk/XL7izwqB81/c57gUueT
 7JbGIo93rrPZBSbxl4uPFdlKER/MOsCGch7FPLktNm+qZ5/Pq7yZMQYyEPI6mDj4RZ1KiOXhwwZ
 PBAWm4Py07enve8DKUn/axhuXKH9qZF9azkLKsHY4gxXKq06nbq12ASgVsdBzjeyMhGwe7aaZnX
 TkRm6GMfNMl4D4XFB0991ptKkvqbWJQz+ggfLNrmldDU1CN/9s9agxSVB6fYA1VL0aFx7TsJMjg
 BbqttP9gHtMdbTwlglwImuy0btI5fPKAGn62O41jiqNJZtkf1pe0SdMbi/Mj7NoXUO7VDa0CWa2
 bDDdOLOvVxz1O+9JqrrpcLUY
X-Received: by 2002:a17:90b:4ccb:b0:3b0:9183:23ef with SMTP id
 98e67ed59e1d1-3b41c7b67femr19436565a91.3.1795671625900; 
 Wed, 25 Nov 2026 21:40:25 -0800 (PST)
Received: from libra05.. ([143.248.188.128]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41aab4729sm30496288a91.0.2026.11.25.21.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 21:40:25 -0800 (PST)
From: Yewon Choi <woni9911@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Thu, 26 Nov 2026 14:40:21 +0900
Message-ID: <20261126054021.462750-1-woni9911@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xWSDf-000000005tR-3Z48
Subject: [f2fs-dev] f2fs: A possible bug on roll-forward recovery (does not
 verify inode checksum)
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Disclosure first: this report was prepared with the help of an AI coding
assistant (Claude). It was used to analyze the code, write the reproducer
and draft this text. I have reproduced the problem myself, reviewed
everything below and take responsibility for it.

I would like to report that roll-forward recovery in f2fs does not verify
the inode checksum.

With the inode_checksum feature enabled, a corrupted fsync'd inode block is
recovered silently after an unclean shutdown and then written back with a fresh,
valid checksum. The same corruption is rejected with -EFSBADCRC on the regular
node read path.

I am not sure whether this is considered as a bug or missing hardening, so I 
am reporting it with a suggestion rather than sending a patch.


Affected versions
-----------------
I tested this on the following versions: f2fs dev branch 
b61a029304bb ("f2fs: don't BUG_ON a missing orphan inode at mount") with 
7.4.0-rc1, x86_64 KVM guest, KASAN enabled, and f2fs-tools 1.16.0. 


Problem description
-------------------
find_fsync_dnodes() and recover_data() read node blocks with
f2fs_get_tmp_cache() and only check the footer via is_recoverable_dnode().
recover_inode() and do_recover_data() then copy i_mode, i_uid/i_gid,
i_size, i_flags, timestamps and the block addresses from that block.
f2fs_inode_chksum_verify() is only called from the node read path in
node.c, so nothing verifies the inode body during roll-forward.

We need the following step to reach the situation:

  1. mkfs.f2fs -O extra_attr,inode_checksum
  2. write + fsync a file (the inode block goes to the warm node log)
  3. that inode block gets corrupted on the device before the next
     checkpoint (for example paired-page corruption or an incomplete
     program on power loss, which is also when roll-forward runs)
  4. unclean shutdown, mount

The corrupted fields are applied without any error or message, the mount
succeeds, and fsck.f2fs reports nothing afterwards. What we observed was a
wrong i_size and files returning wrong content (corrupted block address).
Since the recovered inode is rewritten with a valid checksum, the
corruption cannot be detected later either.

I would say that this is not a security issue and it only concerns accidental
corruption, which is what the feature is there to catch.


Reproducer
----------
Run as root in a test VM (needs f2fs-tools, python3 and a loop device; it
only touches a 256M image file in /tmp):

--- 8< --- repro.sh ---
#!/bin/sh
# Run as root in a test VM. Needs f2fs-tools, python3 and a loop device.
# Usage: sh repro.sh fsync   (inode only in the roll-forward chain)
#        sh repro.sh ckpt    (control: checkpointed inode)
CASE=${1:-fsync}; IMG=/tmp/f2fs-rf.img; MNT=/mnt/f2fs-rf
rm -f $IMG; truncate -s 256M $IMG; mkdir -p $MNT
DEV=$(losetup -f --show $IMG)
mkfs.f2fs -q -f -O extra_attr,inode_checksum $DEV
mount -t f2fs $DEV $MNT
head -c 8192 /dev/zero | tr '\0' A > $MNT/foo; sync
INO=$(stat -c %i $MNT/foo)
if [ $CASE = fsync ]; then
	python3 -c "import os; f = open('$MNT/foo', 'r+b'); f.write(b'B' * 12288); f.flush(); os.fsync(f.fileno())"
	f2fs_io shutdown 2 $MNT		# no checkpoint
fi
umount $MNT

# Flip bit 8 of i_size (byte 17) in the newest on-disk copy of the inode
# block; for "fsync" only copies with the fsync mark in the footer count.
python3 - $DEV $INO $CASE <<'PY'
import os, struct, sys
dev, ino, case = sys.argv[1], int(sys.argv[2]), sys.argv[3]
fd = os.open(dev, os.O_RDWR); best = None
for blk in range(os.lseek(fd, 0, os.SEEK_END) // 4096):
    nid, fino, flag = struct.unpack("<III", os.pread(fd, 12, blk * 4096 + 4072))
    ver = struct.unpack("<Q", os.pread(fd, 8, blk * 4096 + 4084))[0] & 0xffffffff
    if nid == ino == fino and (case != "fsync" or flag & 2):
        if best is None or ver >= best[1]:
            best = (blk, ver)
off = best[0] * 4096 + 17
os.pwrite(fd, bytes([os.pread(fd, 1, off)[0] ^ 1]), off); os.fsync(fd)
print("corrupted inode", ino, "in block", best[0])
PY

dmesg -C
mount -t f2fs $DEV $MNT && stat -c "i_size after mount: %s" $MNT/foo
dmesg | grep -E "checksum|recover_inode"
umount $MNT; losetup -d $DEV
--- >8 ---

Output on f2fs dev b61a029304bb:

  # sh repro.sh fsync
  corrupted inode 4 in block 4609
  i_size after mount: 12544              <- was 12288, no checksum message
  F2FS-fs (loop0): recover_inode: ino = 4, name = foo, inline = 21

  # sh repro.sh ckpt                     (control)
  corrupted inode 4 in block 4608
  stat: cannot statx '/mnt/f2fs-rf/foo': Bad message
  F2FS-fs (loop0): checksum invalid, nid = 4, ino_of_node = 4, 959b6904 vs. a32e4eab


How it was found
----------------
While testing how f2fs recovers from crash images in which a single
already-written block is corrupted, bit flips in inode blocks were always
caught when the inode was covered by a checkpoint (98 of 98), but never
when it was only in the roll-forward chain (0 of 76).


Suggested fix
-------------
Call f2fs_inode_chksum_verify() for inode blocks (IS_INODE()) in
find_fsync_dnodes(), right after the is_recoverable_dnode() check, and
treat a mismatch like the regular read path does (-EFSBADCRC).

I tried exactly that locally on the dev branch: the reproducer no longer
recovers the corrupted inode (i_size stays at the checkpointed value and
"checksum invalid" is logged), and in our crash-image tests only the
roll-forward inode cases changed outcome.

Two things I was unsure about:

1. Abort vs. skip. Stopping roll-forward at the bad block also loses
   later fsync'd files. Skipping only the bad inode and continuing keeps
   more data, but in our states it often left files from different points
   in time (a file fsync'd earlier rolled back, one fsync'd later
   recovered), which may break applications that rely on fsync ordering
   across files. Aborting seemed the safer choice to me.

2. Direct/indirect node blocks carry no checksum, so corrupted block
   addresses there are recovered (and read at runtime) silently. That is
   outside what inode_checksum covers; mentioned only for completeness.

I would send a patch if needed. Let me know if more additional 
information is required. 


Thank you for confirming this issue.

Sincerly,
Yewon Choi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
