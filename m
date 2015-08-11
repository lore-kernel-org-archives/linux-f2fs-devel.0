From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: f2fs for SMR drives
Date: Tue, 11 Aug 2015 18:40:48 +0800
Message-ID: <008b01d0d422$49ac7580$dd056080$@samsung.com>
References: <20150808135117.GA4594@schmorp.de>
	<003d01d0d356$4d5b9480$e812bd80$@samsung.com>
	<20150810130554.GA2347@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZP70B-0004Lu-HY
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Aug 2015 10:41:51 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZP708-0001QZ-7Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Aug 2015 10:41:51 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NSW02X5JZ1DKJ90@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Aug 2015 19:41:37 +0900 (KST)
In-reply-to: <20150810130554.GA2347@schmorp.de>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Marc Lehmann' <schmorp@schmorp.de>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Marc Lehmann [mailto:schmorp@schmorp.de]
> Sent: Monday, August 10, 2015 9:06 PM
> To: Chao Yu
> Cc: Jaegeuk Kim; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] f2fs for SMR drives
> 
> On Mon, Aug 10, 2015 at 06:20:40PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> > '-s7' means that we configure seg_per_sec into 7, so our section size will
> 
> Ah, I see, I am a victim of a documentation bug then: According to the

Sorry about this, it's out of update, Jaegeuk had already sent the patch for
updating the manual.

> > b) In f2fs, we use inode/data block space mixedly, so when data block number
> > is zero, we can't create any file in f2fs. It makes rsync failing in step 2,
> > and leads it runs into discard_receive_data function which will still
> > receiving the whole src file. This makes rsync process keeping writing but
> > generating no IO in f2fs filesystem.
> 
> I am sorry, that cannot be true - if file creation would fail, then rsync
> simply would be unable to write anything, it wouldn't have a valid fd to
> write. I also strace'd it, and it successfully open()ed and "write()ed"
> AND close()ed the file.

[test in f2fs]
I try to use rsync to write 32g file located in ext4 partition into f2fs
partition (32g file is not exist in f2fs partition), f2fs partition is
100% utilized and with no available blocks.

Command: strace rsync -avP --append 32g /mnt/f2fs/32g

This is strace info when reproducing this issue:

read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 262144) = 262144
select(5, NULL, [4], [4], {60, 0})      = 1 (out [4], left {59, 999998})
write(4, "\374\17\0\7", 4)              = 4
select(5, NULL, [4], [4], {60, 0})      = 1 (out [4], left {59, 999999})
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4092) = 4092
select(5, NULL, [4], [4], {60, 0})      = 1 (out [4], left {59, 999999})
write(4, "\374\17\0\7", 4)              = 4
select(5, NULL, [4], [4], {60, 0})      = 1 (out [4], left {59, 999999})
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4092) = 4092

This is just part of message, the whole message is almost fully filled with
the [read, select, write] combination. From this information we can see that
rsync program reads from file with fd:3, and then writes to file with fd:4.

root@fs:/# ps -ef|grep rsync
root     16912  3246 73 13:20 pts/3    00:00:05 rsync -avP --append 32g /mnt/ext4/32g
root     16913 16912  0 13:20 pts/3    00:00:00 rsync -avP --append 32g /mnt/ext4/32g
root     16914 16913 66 13:20 pts/3    00:00:04 rsync -avP --append 32g /mnt/ext4/32g
root     16932 32494  0 13:21 pts/1    00:00:00 grep --color=auto rsync
root@fs:/# ll -l /proc/16912/fd/
total 0
dr-x------ 2 root root  0 Aug 11 13:21 ./
dr-xr-xr-x 9 root root  0 Aug 11 13:21 ../
lrwx------ 1 root root 64 Aug 11 13:21 0 -> /dev/pts/3
lrwx------ 1 root root 64 Aug 11 13:21 1 -> /dev/pts/3
lrwx------ 1 root root 64 Aug 11 13:21 2 -> /dev/pts/3
lr-x------ 1 root root 64 Aug 11 13:21 3 -> /home/yuchao/32g
lrwx------ 1 root root 64 Aug 11 13:21 4 -> socket:[3190839]
lrwx------ 1 root root 64 Aug 11 13:21 5 -> socket:[3190840]

Here, the information can indicate that the file with fd:3 is source file
which path is /home/yuchao/32g, and the file with fd:4 is a socket file.

I guess rsync is designed as a C/S structure, in rsync, client part write
out data of source file through socket, and then server part will receive
these data, finally server part will write the data to destined file in
server.

This can explain why we can see so many 'write' ops in strace information.

root@fs:/# ll -l /proc/16913/fd/
total 0
dr-x------ 2 root root  0 Aug 11 13:21 ./
dr-xr-xr-x 9 root root  0 Aug 11 13:21 ../
lrwx------ 1 root root 64 Aug 11 13:21 1 -> socket:[3190841]
lrwx------ 1 root root 64 Aug 11 13:21 2 -> /dev/pts/3
lrwx------ 1 root root 64 Aug 11 13:21 3 -> socket:[3191842]
root@fs:/# ll -l /proc/16914/fd/
total 0
dr-x------ 2 root root  0 Aug 11 13:21 ./
dr-xr-xr-x 9 root root  0 Aug 11 13:21 ../
lrwx------ 1 root root 64 Aug 11 13:21 0 -> socket:[3190838]
lrwx------ 1 root root 64 Aug 11 13:21 2 -> /dev/pts/3
lrwx------ 1 root root 64 Aug 11 13:21 4 -> socket:[3191843]

[test in ext4]
Then I try to reproduce the issue in ext4 for verification, since I
think if the issue is due to copy model of rsync, ext4 may have the
same issue.

I make an ext4 partition with no available block and no free inode:

root@fs:/home/yuchao/mycode# stat -f /mnt/ext4
  File: "/mnt/ext4"
    ID: b391327e3c675398 Namelen: 255     Type: ext2/ext3
Block size: 1024       Fundamental block size: 1024
Blocks: Total: 122835     Free: 7709       Available: 0
Inodes: Total: 32768      Free: 0

I run rsync with both no option and '-avP --append', we can see the
result below:

root@fs:/home/yuchao # time rsync 32g /mnt/ext4/32g
rsync: mkstemp "/mnt/ext4/.32g.MGVSYA" failed: No space left on device (28)
rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1070) [sender=3.0.9]

real    2m50.020s
user    2m3.820s
sys     0m45.496s

root@fs:/home/yuchao # time rsync -avP --append 32g /mnt/ext4/32g
sending incremental file list
32g
 34359738368 100%  192.13MB/s    0:02:50 (xfer#1, to-check=0/1)
rsync: open "/mnt/ext4/32g" failed: No space left on device (28)

sent 34363932741 bytes  received 31 bytes  200372785.84 bytes/sec
total size is 34359738368  speedup is 1.00
rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1070) [sender=3.0.9]

real    2m50.597s
user    2m4.728s
sys     0m44.796s

So the result shows that:
a) like in f2fs, in ext4 it aslo takes rsync long time to finish the copy,
it looks like we can still keep writing at full fs without reporting ENOSPC;
b) when we fail to create target file in fs, it does not report "No space
left on device (28)" message as soon as possible, but report it when ending
up.

> 
> It can only be explained by f2fs neither creating nor writing the file,
> without giving an error.

I add printks in f2fs_create for tracing, actually I have seen that f2fs
had returned ENOSPC to user space. And also I enable trace in f2fs, I didn't
see any writes are triggered by regular file in f2fs.

> 
> In any case, instead of discarding data, the filesystem should of course
> return ENOSPC, as anything else causes data loss.
> 
> > Can you please help to check that in your environment the reason of rsync
> > without returning ENOSPC is the same as above?
> 
> I can already rule it out baseed on API grounds: if file creation fails
> (e.g. with ENOSPC), then rsync couldn't have an fd to write data to it.
> something else must go on.
> 
> The only way for this behaviour to happen is if file creation succeeds
> (and wriitng and closing, too - silent data loss).
> 
> > If it is not, can you share more details about test steps, io info, and f2fs
> > status info in debugfs (/sys/kernel/debug/f2fs/status).
> 
> I mounted the partition with -onoatime and no other flags, used cp -Rp to
> copy a large tree until the disk utilization was 100% for maybe 20 seconds
> according to /sys/kernel/debug/f2fs/status. A bit puzzled, I ^C's cp,
> and tried "rsync -avP --append", which took a bit to scan the directory
> information, then proceeded to write.
> 
> I also don't think rsync --append goes via the temporary file route, but in
> any case, I also used rsync -avP, which does.
> 
> After writing a few dozen gigabytes (as measured by read data throughput),
> I stopped both.

Thank you for all detail description about the test, it really helps. :)

IMO, it's better to wait for the end of the test instead of stopping them,
so perhaps we can see the result message of rsync which may indicate that
why our target file is not generated.

> 
> I don't know what you mean with "io info".

Sorry, I mean iostat information.

Thanks,

> 
> Since fsck.f2fs completely destroyed the filesystem, I cannot provide any
> more f2fs debug info about it.
> 
> > IMO, real-timely increasing ratio of below stat value may be helpful to
> > investigate the degression issue. Can you share us them?
> 
> I lost this filesystem to corruption as well. I will certainly retry this
> test though, and will record these values.
> 
> Anyways, thanks a lot for your input so far!
> 
> --
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\


------------------------------------------------------------------------------
