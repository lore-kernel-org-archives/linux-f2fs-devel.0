From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: f2fs: prevent mount with "extended node bitmap" on older
 kernels
Date: Sun, 9 Dec 2018 12:51:23 +0000
Message-ID: <CAD14+f18VYrabAOvZocx3U3V9j0pKFHBBK+UzvygO=m5Aa_EKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1gVyYe-0001Sw-VQ
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 09 Dec 2018 12:51:40 +0000
Received: from mail-ua1-f46.google.com ([209.85.222.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gVyYd-007t8w-5c
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 09 Dec 2018 12:51:40 +0000
Received: by mail-ua1-f46.google.com with SMTP id d21so2912743uap.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 09 Dec 2018 04:51:38 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hi,

I was testing around the "extended node bitmap" feature within f2fs
and found an issue with fsck.f2fs resulting in false-positives
and causing further corruptions when data is written by older kernels.

I can reliably reproduce this issue with a simple image creation
and fsck with Linux 4.15.

# fallocate -l 2G f2fs.img
# mkfs.f2fs -i f2fs.img
# mount f2fs.img /mnt
# rsync -a /var/ /mnt/
# umount /mnt
# fsck.f2fs -f --dry-run f2fs.img

This results in the following behavior with the latest f2fs-tools
v1.12.0 and Linux 4.15:
https://pastebin.com/MTKpa2AC
(A side note, 2nd run of fsck still shows some errors being fixed.)

I cannot reproduce this issue with Linux 4.19.
Is this new feature supposed to be only used with recent kernels?

If so, mount should be prevented on older kernels, at least writes.
(I'm noticing reads are fine with older kernels.)

Thanks,
