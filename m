Return-Path: <SRS0=KVXo=4X=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6842C3F2D2
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:46:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2E62070E;
	Fri,  6 Mar 2020 00:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="iHzsNqAW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="I0Lb5W22";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW4Vk6Jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2E62070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jA17w-0002uL-8P; Fri, 06 Mar 2020 00:46:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jA17u-0002tr-Pc
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Mar 2020 00:46:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y6LfuViAyfvzMUGMyDDI7RnYXmjNsu9gh5KZGzuU1Qk=; b=iHzsNqAWKFa9keVHBnYOkGgipK
 Btk3eQMmDN7+cwlTsyFoFxAiKwcY8oNCqj+OLd/mlel4QW/X61qYw8jPtjIZLdOu2VozcRiN/PqCi
 IVc1vrbUzrCb34/dkgZW3tXBY9V19CFIeK1HAOcThsu8knrsACLbYguTaUk9IKaXlU2c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y6LfuViAyfvzMUGMyDDI7RnYXmjNsu9gh5KZGzuU1Qk=; b=I
 0Lb5W22u0UoHR6asFWYJfgjciqJTjawWokf7k/tbS63zChjLQbJ8PDSdkl9Jkt0LRVCV5PFU+iGyQ
 3X4En6Jr/V/37gXP9gAdP6cJxBcPr0L1zS31NreJHM+vugDj7kRQpxtwmWrkcnYcbLgEUCYCJWFV1
 eXzoqMweD+duX2SU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jA17q-00HSsh-LJ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Mar 2020 00:46:06 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DD56E2070E;
 Fri,  6 Mar 2020 00:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583455557;
 bh=fGx37LlA+EG4g7xaMt+UAx7ZpIiPij5CT5m8UDigDpE=;
 h=Date:From:To:Cc:Subject:From;
 b=MW4Vk6JvFjyAkqLILduCSVnHoFDTP44wh8BDtkn3mMCcS3QOVTbqORQOYyHbCVBo6
 QB7uLmdz+7k/bhThcepfO6I4noScDXO4lwBfZrbsjO7nJq/F7DXS/DLq9PNlIrm/0Y
 LUoljjpLlpCbARZKFMZ3rRkGhG9eAYDUb82nAOiM=
Date: Thu, 5 Mar 2020 16:45:55 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Message-ID: <20200306004555.GB225345@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Headers-End: 1jA17q-00HSsh-LJ
Subject: [f2fs-dev] lazytime causing inodes to remain dirty after sync?
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
Cc: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

While testing my patch "fscrypt: don't evict dirty inodes after removing key"
(https://lkml.kernel.org/r/20200305084138.653498-1-ebiggers@kernel.org), I've
run into an issue where even after the filesystem is sync'ed and no files are
in-use, inodes can remain dirty if the filesystem is mounted with -o lazytime.
Thus, my patch causes some inodes to not be evicted when they should be.

(lazytime is the default on f2fs, but ext4 supports it too.)

This is caused by the following code in __writeback_single_inode() that
redirties the inode if its access time is dirty:

	if (dirty & I_DIRTY_TIME)
		mark_inode_dirty_sync(inode);
	/* Don't write the inode if only I_DIRTY_PAGES was set */
	if (dirty & ~I_DIRTY_PAGES) {
		int err = write_inode(inode, wbc);
		if (ret == 0)
			ret = err;
	}
	trace_writeback_single_inode(inode, wbc, nr_to_write);
	return ret;

Here's a reproducer in the kvm-xfstests test appliance which demonstrates the
problem using sync(), without fscrypt involved at all:

	sysctl vm.dirty_expire_centisecs=500
	umount /vdc
	mkfs.ext4 -F /dev/vdc
	mount /vdc -o lazytime
	echo contents > /vdc/file
	sync
	ino=$(stat -c %i /vdc/file)
	echo 1 | tee /sys/kernel/debug/tracing/events/writeback/writeback_{single_inode_start,mark_inode_dirty,lazytime}/enable
	echo "ino == $ino" | tee /sys/kernel/debug/tracing/events/writeback/writeback_{single_inode_start,mark_inode_dirty,lazytime}/filter
	echo > /sys/kernel/debug/tracing/trace
	cat /vdc/file > /dev/null
	sync
	cat /sys/kernel/debug/tracing/trace_pipe

The tracing shows that the inode for /vdc/file is written during the sync at
7.28s.  But then, still during the sync, it's immediately re-dirtied.  It then
gets written again later in the background, after the sync.

             cat-286   [001] ...1     7.279433: writeback_mark_inode_dirty: bdi 254:32: ino=12 state= flags=I_DIRTY_TIME
    kworker/u8:0-8     [003] ...1     7.282647: writeback_single_inode_start: bdi 254:32: ino=12 state=I_SYNC|I_DIRTY_TIME|I_DIRTY_TIME_EXPIRED dirtied_when=4294879420 age=0 index=1 to_write=9223372036854775807 wrote=0 cgroup_ino=1
    kworker/u8:0-8     [003] ...2     7.282660: writeback_lazytime: dev 254,32 ino 12 dirtied 4294879420 state I_SYNC|I_DIRTY_TIME|I_DIRTY_TIME_EXPIRED mode 0100644
    kworker/u8:0-8     [003] ...1     7.283204: writeback_mark_inode_dirty: bdi 254:32: ino=12 state=I_SYNC flags=I_DIRTY_SYNC
    kworker/u8:0-8     [003] ...1    12.412079: writeback_single_inode_start: bdi 254:32: ino=12 state=I_DIRTY_SYNC|I_SYNC dirtied_when=4294879421 age=5 index=1 to_write=13312 wrote=0 cgroup_ino=1

Is this behavior intentional at all?  It seems like a bug; it seems the inode
should be written just once, during the sync.  

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
