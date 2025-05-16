Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E38AC3ABC9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 May 2025 11:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hQbWg78iCRKTxkrLjF+JFYeAW+tvSz1jFu5jXeBvynI=; b=M3NHi1IGFG0tMptkMvAOyOMQ8F
	qg/+22X7+9pgO+kbxhtLA7Y61eaO+ww/itFHJ5s6znbLGSBvVvLV49BHShYQk8bvyxeNrxauA4laQ
	w5KKdtVaxlyrUEvM3MmMFLA6TYnlW9VGjtxV/efd9J0JWaIqZcIUV5nXs2nfd+EY44kE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uFtHn-0004Qo-Bg;
	Fri, 16 May 2025 11:31:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dungeonlords789@naver.com>) id 1uFtHm-0004Qi-3W
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 May 2025 11:31:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VHpY7ie++0npeWwQcDmnU7bpIj+7Bg/hDWznGdcczjY=; b=XGc66gRy7vXj9hQOysNT3O/1Cu
 zFOgUMv3BhfuqP7VXoHHmCRGzaGBhS7+aWuaakRNXOHN0sixhyONvUTQQuCsVVILEWfQ12bKrU8/I
 8NcRRfAhZkk6m2Ctq8WHMtCiTLqcAPSTxWpAfbzm74COi8ZRf3VT5R1xbSRkhsDRtAbk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VHpY7ie++0npeWwQcDmnU7bpIj+7Bg/hDWznGdcczjY=; b=X
 UDY60nEcTydvDvljmN4Aydz3BNG0Vm9gQwRCUERBqoX+Kl0gaLdqS9VFeghrkWia6BCfyWoFvl1aK
 pUQJk+TfZcWz3FtNcMmv5w+eeQCXTWjCL4mP23nxTlItk82PzhZFVfB9kH9iLdzEYRJjfYCBkdgBe
 t6C/x+j+BJsjGWjg=;
Received: from cvsmtppost08.nm.naver.com ([114.111.35.229])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uFtHk-00059G-M2 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 May 2025 11:31:30 +0000
X-Originating-IP: 125.132.232.68
Received: from cvsendbo023.nm ([10.112.22.35])
 by cvsmtppost08.nm.naver.com with ESMTP id jEIkOD8sROivFrtIGKwtbQ
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 16 May 2025 11:10:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208; 
 t=1747393859; bh=0Gf9n91h8Z9OXsWukB5wx2lGeGwhhfYZbg7DaO+xvzA=; 
 h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
 X-Works-Security;
 b=xXn0FsLAujTcHmLTPxGoJ19Jhf7Bjt5fNDv795bpejmvmSZCY8uUXyqDmzjwNBfzE
 RXJpQqBQP+/bwRNTifKbsh7X1AbEeFpZ63naSvnLfBBS00lJPyu5ML6zrKAFxe+7UK
 ufEkpQlC+2C9iLGCoSgXk0N/RoF0PDoRLxj8g+uNx9XXPZ58iTotTB8NtTNylY4XbP
 uIIx1zrhh9ua40aofg+wBeDDp7A5/4yY3BC2OmpgFPtQgokTNm3Npr104UXfTxUoeY
 P3j0WA8FwIfYKX43geeCytZerzu2MLMlde82WuMas90MrbAXZR8G+9NtHoi6Oz3YRl
 WRSV9hIgRCyWg==
X-Session-ID: EZCJZK33Rl+3y6RaqStdug
X-Originating-IP: 125.132.232.68
X-Works-Send-Opt: E/YqjAJYjHmlKxu/FoJYKxgXKBwkx0eFjAJYKg==
X-Works-Smtp-Source: YqnrKqbdFqJZ+Hm/Fxtw+6E=
Received: from Linux.. ([125.132.232.68])
 by cvnsmtp003.nm.naver.com with ESMTP id EZCJZK33Rl+3y6RaqStdug
 for <multiple recipients>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 16 May 2025 11:10:58 -0000
From: Cherniaev Andrei <dungeonlords789@naver.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 16 May 2025 20:10:26 +0900
Message-ID: <20250516111026.134657-1-dungeonlords789@naver.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Headers-End: 1uFtHk-00059G-M2
Subject: [f2fs-dev] [PATCH 1/1] f2fs-tools: increase overprovision finding
 speed
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
Cc: jaegeuk@kernel.org, Cherniaev Andrei <dungeonlords789@naver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I think my optimization makes mkfs.f2fs faster in case of invalid volume size. So with the commit user will get err faster.
Before start I suggest add debug printf() to `f2fs_fs.h` like this:
```
for (; candidate <= end; candidate += diff) {
	reserved = get_reserved(sb, candidate);
	ovp = (usable_main_segs - reserved) * candidate / 100;
MSG(0, "ovp=%f usable_main_segs=%u reserved=%u candidate=%f\n", ovp, usable_main_segs, reserved, candidate); //debug printf()
if (ovp <= 0)
		continue;
	space = usable_main_segs - max((double)reserved, ovp) -
				overprovision_segment_buffer(sb);
MSG(0, "space=%f max_space=%f\n", space, max_space); //debug printf()
	if (max_space < space) {
		max_space = space;
		max_ovp = candidate;
	}
}
```

Test instruction is based on "boot/grub2/readme.txt" https://gitlab.com/buildroot.org/buildroot/-/blob/master/boot/grub2/readme.txt You can use Ubuntu 24 or similar OS.
1. Create a disk image
```
cd /tmp
dd if=/dev/zero of=disk.img bs=1M count=32
```
2. Partition it with GPT partitions usinig `cgdisk disk.img` or
```
parted --script disk.img mklabel gpt mkpart primary 1MiB 31MiB
```
3. Setup loop device and loop partitions
```
loop_dev=$(sudo losetup -f --show disk.img)
sudo partx -a "$loop_dev"
```
5. Prepare the root partition
```
sudo mkfs.f2fs -f -l mylable123 -i -O extra_attr,inode_checksum,sb_checksum,compression -e raw -E bin "$loop_dev"
```
6. Cleanup loop device
```
partx -d "$loop_dev"
losetup -d "$loop_dev"
```
In log you can see that for ovp==0.0 space calculation looks not necessary...
```
a@Linux:~$ sudo mkfs.f2fs -f -l mylable123 -i -O extra_attr,inode_checksum,sb_checksum,compression -e raw -E bin "$loop_dev"

    F2FS-tools: mkfs.f2fs Ver: 1.16.0 (2025-05-06)

Info: Debug level = 0
Info: Add new cold file extension list
Info: Add new hot file extension list
Info: Label = mylable123
Info: Trim is enabled
Info: Enable Compression
Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 512
Info: total sectors = 65536 (32 MB)
Info: zone aligned segment0 blkaddr: 512
ovp=429496728.700000 usable_main_segs=8 reserved=17 candidate=10.000000
space=-429496726.700000 max_space=0.000000
ovp=644245093.650000 usable_main_segs=8 reserved=13 candidate=15.000000
space=-644245091.650000 max_space=0.000000
ovp=858993458.400000 usable_main_segs=8 reserved=12 candidate=20.000000
space=-858993456.400000 max_space=0.000000
ovp=1073741823.250000 usable_main_segs=8 reserved=11 candidate=25.000000
space=-1073741821.250000 max_space=0.000000
ovp=1288490188.200000 usable_main_segs=8 reserved=10 candidate=30.000000
space=-1288490186.200000 max_space=0.000000
ovp=1503238553.250000 usable_main_segs=8 reserved=9 candidate=35.000000
space=-1503238551.250000 max_space=0.000000
ovp=1717986918.000000 usable_main_segs=8 reserved=9 candidate=40.000000
space=-1717986916.000000 max_space=0.000000
ovp=1932735282.750000 usable_main_segs=8 reserved=9 candidate=45.000000
space=-1932735280.750000 max_space=0.000000
ovp=2147483647.500000 usable_main_segs=8 reserved=9 candidate=50.000000
space=-2147483645.500000 max_space=0.000000
ovp=0.000000 usable_main_segs=8 reserved=8 candidate=55.000000
space=-6.000000 max_space=0.000000
ovp=0.000000 usable_main_segs=8 reserved=8 candidate=60.000000
space=-6.000000 max_space=0.000000
ovp=0.000000 usable_main_segs=8 reserved=8 candidate=65.000000
space=-6.000000 max_space=0.000000
ovp=0.000000 usable_main_segs=8 reserved=8 candidate=70.000000
space=-6.000000 max_space=0.000000
ovp=0.000000 usable_main_segs=8 reserved=8 candidate=75.000000
space=-6.000000 max_space=0.000000
ovp=0.000000 usable_main_segs=8 reserved=8 candidate=80.000000
space=-6.000000 max_space=0.000000
ovp=0.000000 usable_main_segs=8 reserved=8 candidate=85.000000
space=-6.000000 max_space=0.000000
ovp=0.000000 usable_main_segs=8 reserved=8 candidate=90.000000
space=-6.000000 max_space=0.000000
ovp=0.000000 usable_main_segs=8 reserved=8 candidate=95.000000
space=-6.000000 max_space=0.000000
	Error: Device size is not sufficient for F2FS volume
	Error: Failed to prepare a super block!!!
	Error: Could not format the device!!!
```

Signed-off-by: Cherniaev Andrei <dungeonlords789@naver.com>
---
 include/f2fs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index f7268d1..41755af 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1891,7 +1891,7 @@ static inline double get_best_overprovision(struct f2fs_super_block *sb)
 	for (; candidate <= end; candidate += diff) {
 		reserved = get_reserved(sb, candidate);
 		ovp = (usable_main_segs - reserved) * candidate / 100;
-		if (ovp < 0)
+		if (ovp <= 0)
 			continue;
 		space = usable_main_segs - max((double)reserved, ovp) -
 					overprovision_segment_buffer(sb);
-- 
2.45.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
