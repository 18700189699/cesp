package com.uxsino.Netty.socket;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import net.sf.json.JSONObject;

import java.nio.ByteOrder;

public class TestNetty2 {

	//消息总是以一个字节大小的命令作为开始，因此该值被编码为常量
	private static final byte COMMand = (byte)1;

	//因为消息的大小不一，所以处于效率考虑，在ByteBug创建之前将先计算它
	public ByteBuf toBuffer(){
		short size = (short) (1+
			4 + //Identifier
			4 + //Expiry
			2 + //DT length header
			32 + //DS length
			2 //body length header
		);

		//在创建时，ByteBuf的大小正好，并且指定用于大端字节序
		ByteBuf buf = Unpooled.buffer(size).order(ByteOrder.BIG_ENDIAN);
		buf.writeByte(COMMand);
		//buf.writeInt()
		//buf.writeInt()
		//buf.writeShort();
		// buf.writeBytes()
		//buf.writeShort();
		// buf.writeBytes()

		//当缓冲区已经就绪是，简单返回即可
		return buf;
	}

}
