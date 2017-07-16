From: "Marcelo \"Marc\" Ranolfi" <marc.2377@gmail.com>
Subject: Re: Fwd: fsck.f2fs fails with "can't find valid
 checkpoint"
Date: Sun, 16 Jul 2017 02:45:16 -0300
Message-ID: <CAETC-g8iHogVHcxYPkzWPVudQwhENAeB_qsv-CBwz6jd_GJTTQ@mail.gmail.com>
References: <CAETC-g8rBb53ibGYPciFjgN-uKK7xahPJZVGs8NsR+=0Qpu+oQ@mail.gmail.com>
	<CAOtxgydToHmRwgWa1mc13wB9tuZPREokNCE4qo83As_LgeU9-Q@mail.gmail.com>
	<20170705035359.GE15448@jaegeuk-macbookpro.roam.corp.google.com>
	<CAETC-g-3rmSN7COQ47x=kOyPc5-Hp7O5CVJyUOsbnvKW5h_sBA@mail.gmail.com>
	<CAETC-g9YsiUzTLzAF-HMjcWkmTSxCU34gUWqV4Mc733=h5zfVg@mail.gmail.com>
	<20170706015733.GB50622@jaegeuk-macbookpro.roam.corp.google.com>
	<CAETC-g9GnW1=awqmN+_D5QuH7bvnA1DYyfzDZZ5nL+hdLRu2VA@mail.gmail.com>
	<20170706210622.GA395@jaegeuk-macbookpro.roam.corp.google.com>
	<CAETC-g8hjjMFnSKk5k-HnxwPAdGhdopqoD8yvRt_-j0F5zsE6w@mail.gmail.com>
	<20170716010702.GB51202@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <marc.2377@gmail.com>) id 1dWcMw-00067o-G3
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 16 Jul 2017 05:45:26 +0000
Received: from mail-lf0-f67.google.com ([209.85.215.67])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dWcMu-0006p1-9Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 16 Jul 2017 05:45:26 +0000
Received: by mail-lf0-f67.google.com with SMTP id g21so10941804lfk.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 15 Jul 2017 22:45:24 -0700 (PDT)
In-Reply-To: <20170716010702.GB51202@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Sure thing. Let me just figure out how to do it, and get back to you.

On Sat, Jul 15, 2017 at 10:07 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> On 07/12, Marcelo "Marc" Ranolfi wrote:
>> Hi Mr. Kim,
>>
>> I managed to compress the fs image to 14 GiB. As I couldn't find any
>> reliable service that will let me share this for free, and since the
>> upload will take about 20 hours due to my limited upstream link, I'm
>> wondering, if we could transfer via Syncthing (https://syncthing.net)
>> which is a file sync tool I'm familiar with, very capable.
>>
>> Or if you have a better suggestion, I'll sure be interested.
>
> Thank you for taking time. If you have Linux box, how about giving me
> an temp account to access your machine via ssh?
>
> Thanks,
>
>>
>> Thanks.
>> Marc
>>
>> On Thu, Jul 6, 2017 at 6:06 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>> > On 07/05, Marcelo "Marc" Ranolfi wrote:
>> >> Sure. I'll try to compress it, and investigate a way of sharing.
>> >>
>> >> If a partial image (first X sectors|MB|GB) and/or a sample from the middle
>> >> and end is enough, at least as a starting point, it can be a lot easier.
>> >> Let me know.
>> >
>> > Not sure for the first bytes, since it checks partition size in the beginning.
>> > Let me have a full image.
>> >
>> > Thanks,
>> >
>> >>
>> >> Thanks
>> >>
>> >> On Wed, Jul 5, 2017 at 10:57 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>> >>
>> >> > On 07/05, Marcelo "Marc" Ranolfi wrote:
>> >> > > In the meantime, I was able to run photorec on the decrypted disk
>> >> > > /dev/mapper/csystem, and recovered 22 GB of files. I already found some
>> >> > of
>> >> > > the most important work files which weren't backed up, using grep.
>> >> > > Directory structure is lost, but this I can sort out given some time. But
>> >> > > photorec didn't recover any files without extension, which is sad
>> >> > because I
>> >> > > had a directory full of them.
>> >> > >
>> >> > > This, combined with the result of 'fsck.f2fs -d 3' and the fact that
>> >> > > 'cryptsetup open' doesn't complain about anything, makes me believe this
>> >> > is
>> >> > > a filesystem issue.
>> >> > >
>> >> > > How would it be possible to recover checkpoint manually?
>> >> >
>> >> > Hmm, if possible, could you please share the decrypted image? I'll take a
>> >> > look at it.
>> >> >
>> >> > Thanks,
>> >> >
>> >> > >
>> >> > > Thanks
>> >> > > Marcelo "Marc" Ranolfi
>> >> > >
>> >> > > On Wed, Jul 5, 2017 at 6:14 AM, Marcelo "Marc" Ranolfi <
>> >> > marc.2377@gmail.com>
>> >> > > wrote:
>> >> > >
>> >> > > > Kim,
>> >> > > >
>> >> > > > I received your reply in the mailing list, but again, couldn't reply.
>> >> > > >
>> >> > > > The partition is 38GB. Do you need a full image, or only part of it?
>> >> > Also,
>> >> > > > do you need it encrypted, and if yes, the decryption key as well? Or
>> >> > only
>> >> > > > decrypted?
>> >> > > >
>> >> > > > I tried '-d 3' and got the following:
>> >> > > >
>> >> > > > --
>> >> > > > # fsck.f2fs -d 3 /dev/mapper/csystem
>> >> > > > Info: Debug level = 3
>> >> > > > Info: Segments per section = 1
>> >> > > > Info: Sections per zone = 1
>> >> > > > Info: sector size = 512
>> >> > > > Info: total sectors = 78120960 (38145 MB)
>> >> > > > Info: MKFS version
>> >> > > >   "Linux version 4.10.13-1-ARCH (builduser@tobias) (gcc version 6.3.1
>> >> > > > 20170306 (GCC) ) #1 SMP PREEMPT Thu Apr 27 12:15:09 CEST 2017"
>> >> > > > Info: FSCK version
>> >> > > >   from "Linux version 4.11.7-1-ARCH (builduser@tobias) (gcc version
>> >> > 7.1.1
>> >> > > > 20170621 (GCC) ) #1 SMP PREEMPT Sat Jun 24 09:07:09 CEST 2017"
>> >> > > >     to "Linux version 4.11.7-1-ARCH (builduser@tobias) (gcc version
>> >> > 7.1.1
>> >> > > > 20170621 (GCC) ) #1 SMP PREEMPT Sat Jun 24 09:07:09 CEST 2017"
>> >> > > > Info: superblock features = 0 :
>> >> > > > Info: superblock encrypt level = 0, salt =
>> >> > 000000000000000000000000000000
>> >> > > > 00
>> >> > > >
>> >> > > > +--------------------------------------------------------+
>> >> > > > | Super block                                            |
>> >> > > > +--------------------------------------------------------+
>> >> > > > magic                                 [0xf2f52010 : 4076150800]
>> >> > > > major_ver                             [0x       1 : 1]
>> >> > > > volum_name                            []
>> >> > > > minor_ver                             [0x       8 : 8]
>> >> > > > log_sectorsize                        [0x       9 : 9]
>> >> > > > log_sectors_per_block                 [0x       3 : 3]
>> >> > > > log_blocksize                         [0x       c : 12]
>> >> > > > log_blocks_per_seg                    [0x       9 : 9]
>> >> > > > segs_per_sec                          [0x       1 : 1]
>> >> > > > secs_per_zone                         [0x       1 : 1]
>> >> > > > checksum_offset                       [0x       0 : 0]
>> >> > > > block_count                           [0x  950100 : 9765120]
>> >> > > > section_count                         [0x    4a01 : 18945]
>> >> > > > segment_count                         [0x    4a7f : 19071]
>> >> > > > segment_count_ckpt                    [0x       2 : 2]
>> >> > > > segment_count_sit                     [0x       2 : 2]
>> >> > > > segment_count_nat                     [0x      54 : 84]
>> >> > > > segment_count_ssa                     [0x      26 : 38]
>> >> > > > segment_count_main                    [0x    4a01 : 18945]
>> >> > > > segment0_blkaddr                      [0x     200 : 512]
>> >> > > > cp_blkaddr                            [0x     200 : 512]
>> >> > > > sit_blkaddr                           [0x     600 : 1536]
>> >> > > > nat_blkaddr                           [0x     a00 : 2560]
>> >> > > > ssa_blkaddr                           [0x    b200 : 45568]
>> >> > > > main_blkaddr                          [0x    fe00 : 65024]
>> >> > > > root_ino                              [0x       3 : 3]
>> >> > > > node_ino                              [0x       1 : 1]
>> >> > > > meta_ino                              [0x       2 : 2]
>> >> > > > cp_payload                            [0x       0 : 0]
>> >> > > > version                       Linux version 4.11.7-1-ARCH
>> >> > (builduser@tobias)
>> >> > > > (gcc version 7.1.1 20170621 (GCC) ) #1 SMP PREEMPT Sat Jun 24 09:07:09
>> >> > CEST
>> >> > > > 2017
>> >> > > > Info: total FS sectors = 78120960 (38145 MB)
>> >> > > > [f2fs_do_mount:2018] Can't find valid checkpoint
>> >> > > > --
>> >> > > >
>> >> > > > Thanks
>> >> > > > Marcelo "Marc" Ranolfi
>> >> > > >
>> >> > > > On Wed, Jul 5, 2017 at 12:53 AM, Jaegeuk Kim <jaegeuk@kernel.org>
>> >> > wrote:
>> >> > > >
>> >> > > >> On 07/04, Jaegeuk Kim wrote:
>> >> > > >> > + f2fs mailing list
>> >> > > >> >
>> >> > > >> > ---------- Forwarded message ----------
>> >> > > >> > From: Marcelo "Marc" Ranolfi <marc.2377@gmail.com>
>> >> > > >> > Date: 2017-07-04 18:52 GMT-07:00
>> >> > > >> > Subject: Fwd: fsck.f2fs fails with "can't find valid checkpoint"
>> >> > > >> > To: Jaegeuk Kim <jaegeuk.kim@gmail.com>
>> >> > > >> >
>> >> > > >> >
>> >> > > >> >
>> >> > > >> > ---------- Forwarded message ----------
>> >> > > >> > From: Marcelo "Marc" Ranolfi <marc.2377@gmail.com>
>> >> > > >> > Date: Tue, Jul 4, 2017 at 3:54 PM
>> >> > > >> > Subject: fsck.f2fs fails with "can't find valid checkpoint"
>> >> > > >> > To: linux-f2fs-devel@lists.sourceforge.net
>> >> > > >> >
>> >> > > >> >
>> >> > > >> > (reposting because yesterday's email didn't work)
>> >> > > >> >
>> >> > > >> > Gentlemen,
>> >> > > >> >
>> >> > > >> > I was using F2FS in my system when it crashed, and since then, I
>> >> > can't
>> >> > > >> boot
>> >> > > >> > it, nor mount the root partition, and fsck doesn't help. I'm typing
>> >> > this
>> >> > > >> > from a live CD.
>> >> > > >> >
>> >> > > >> > The system is Arch Linux with the 4.12-rc7 kernel (I was compiling
>> >> > the
>> >> > > >> > stable kernel when it crashed). I posted about it here (
>> >> > > >> > https://unix.stackexchange.com/questions/375114/f2fs-lost-d
>> >> > > >> > ata-wont-mount-and-fsck-doesnt-work) but that probably won't help
>> >> > much.
>> >> > > >> > The gist of the story is that I'm trying these commands, from the
>> >> > arch
>> >> > > >> iso
>> >> > > >> > image:
>> >> > > >> >
>> >> > > >> > cryptsetup open /dev/sda3 csystem
>> >> > > >>
>> >> > > >> So, you did encrypt the disk, and then got sudden power-off.
>> >> > > >>
>> >> > > >> > fsck.f2fs -f /dev/mapper/csystem
>> >> > > >>
>> >> > > >> After then, fsck.f2fs can't find checkpoint, which means your
>> >> > encrypted
>> >> > > >> disk is
>> >> > > >> severely damaged. Once such the encrypted disk has been crashed, it's
>> >> > very
>> >> > > >> difficult to recover there-in files from filesystem level, since
>> >> > > >> checkpoint in
>> >> > > >> f2fs is not recoverable. Because, we don't expect two checkpoint
>> >> > copies
>> >> > > >> were
>> >> > > >> crashed at the same time.
>> >> > > >>
>> >> > > >> How's your fsck.f2fs -d 3 result? And, can you share your image? If
>> >> > it's
>> >> > > >> not
>> >> > > >> easy to recover checkpoint manually, I think it needs to write a tool
>> >> > to
>> >> > > >> scan
>> >> > > >> whole disk to find recoverable files. But, it'll take time.
>> >> > > >>
>> >> > > >> Thanks,
>> >> > > >>
>> >> > > >> >
>> >> > > >> > and instead of repairing, it reports:
>> >> > > >> >
>> >> > > >> > [f2fs_do_mount:2018] Can't find valid checkpoint
>> >> > > >> >
>> >> > > >> > The documentation available in the Kernel tree (
>> >> > > >> > https://github.com/torvalds/linux/blob/master/Documentation
>> >> > > >> > /filesystems/f2fs.txt) says under fsck.f2fs:
>> >> > > >> > "Note that, initial version of the tool does not fix any
>> >> > inconsistency."
>> >> > > >> >
>> >> > > >> > However that's not mentioned in the following sources:
>> >> > > >> > https://www.mankier.com/8/fsck.f2fs
>> >> > > >> > https://lkml.org/lkml/2014/9/20/104
>> >> > > >> >
>> >> > > >> > I suppose the Kernel doc is outdated, since from inspecting the fsck
>> >> > > >> source
>> >> > > >> > code, I think it should work.
>> >> > > >> >
>> >> > > >> >
>> >> > > >> > So, I'd like to know whether I'm facing a bug in the tool, or if
>> >> > > >> something
>> >> > > >> > specific to my case is preventing the tool to work. And of course,
>> >> > I'm
>> >> > > >> > really in need of having my files back.
>> >> > > >> >
>> >> > > >> > I'm a programmer so please let me know if I can be of any help, if
>> >> > need
>> >> > > >> be.
>> >> > > >> >
>> >> > > >> >
>> >> > > >> > Yours faithfully
>> >> > > >> > Marcelo "Marc" Ranolfi
>> >> > > >>
>> >> > > >> ------------------------------------------------------------
>> >> > > >> ------------------
>> >> > > >> Check out the vibrant tech community on one of the world's most
>> >> > > >> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> >> > > >> _______________________________________________
>> >> > > >> Linux-f2fs-devel mailing list
>> >> > > >> Linux-f2fs-devel@lists.sourceforge.net
>> >> > > >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>> >> > > >>
>> >> > > >
>> >> > > >
>> >> >

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
